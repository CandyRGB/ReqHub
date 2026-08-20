Unicode true

!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"
!include "FileFunc.nsh"
!include "StrFunc.nsh"

${StrStr}
${UnStrStr}

!ifndef APP_VERSION
  !define APP_VERSION "1.0.0"
!endif

!ifndef APP_VERSION_NUMERIC
  !define APP_VERSION_NUMERIC "1.0.0.0"
!endif

!ifndef BUILD_DIR
  !error "BUILD_DIR must point to the Flutter Windows Release directory."
!endif

!ifndef OUTPUT_FILE
  !define OUTPUT_FILE "ReqHub-Setup-${APP_VERSION}-x64.exe"
!endif

!define APP_NAME "ReqHub"
!define APP_EXE "reqhub.exe"
!define APP_PUBLISHER "CandyRGB"
!define APP_URL "https://github.com/CandyRGB/ReqHub"
!define APP_REGISTRY_KEY "Software\ReqHub"
!define APP_UNINSTALL_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\ReqHub"

Name "${APP_NAME}"
OutFile "${OUTPUT_FILE}"
InstallDir "C:\Program Files\ReqHub"
InstallDirRegKey HKLM "${APP_REGISTRY_KEY}" "InstallDir"
RequestExecutionLevel admin
ManifestSupportedOS all

SetCompressor /SOLID lzma
SetCompressorDictSize 64
SetDatablockOptimize on
SetOverwrite on
CRCCheck on
ShowInstDetails show
ShowUninstDetails show

VIProductVersion "${APP_VERSION_NUMERIC}"
VIAddVersionKey /LANG=1033 "ProductName" "${APP_NAME}"
VIAddVersionKey /LANG=1033 "ProductVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=1033 "CompanyName" "${APP_PUBLISHER}"
VIAddVersionKey /LANG=1033 "FileDescription" "${APP_NAME} Installer"
VIAddVersionKey /LANG=1033 "FileVersion" "${APP_VERSION}"
VIAddVersionKey /LANG=1033 "LegalCopyright" "Copyright (C) 2026 ${APP_PUBLISHER}"

!ifdef APP_ICON
  !define MUI_ICON "${APP_ICON}"
  !define MUI_UNICON "${APP_ICON}"
!endif

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APP_EXE}"
!define MUI_FINISHPAGE_RUN_TEXT "$(LaunchReqHub)"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

LangString LaunchReqHub ${LANG_SIMPCHINESE} "运行 ReqHub"
LangString LaunchReqHub ${LANG_ENGLISH} "Launch ReqHub"
LangString AppRunning ${LANG_SIMPCHINESE} "ReqHub 正在运行。请关闭应用后点击“重试”，或点击“取消”退出。"
LangString AppRunning ${LANG_ENGLISH} "ReqHub is running. Close it and click Retry, or click Cancel to exit."
LangString X64Required ${LANG_SIMPCHINESE} "ReqHub 需要 64 位 Windows。"
LangString X64Required ${LANG_ENGLISH} "ReqHub requires 64-bit Windows."
LangString DesktopShortcut ${LANG_SIMPCHINESE} "创建桌面快捷方式"
LangString DesktopShortcut ${LANG_ENGLISH} "Create a desktop shortcut"
LangString InvalidUninstallDirectory ${LANG_SIMPCHINESE} "未找到 ReqHub 安装标记。为防止误删文件，卸载已取消。"
LangString InvalidUninstallDirectory ${LANG_ENGLISH} "The ReqHub installation marker was not found. Uninstall was cancelled to prevent accidental file deletion."

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY

  ${IfNot} ${RunningX64}
    MessageBox MB_OK|MB_ICONSTOP "$(X64Required)"
    Abort
  ${EndIf}

  SetRegView 64
  SetShellVarContext all
FunctionEnd

Function EnsureReqHubClosed
check_process:
  nsExec::ExecToStack '"$SYSDIR\tasklist.exe" /FI "IMAGENAME eq ${APP_EXE}" /NH'
  Pop $0
  Pop $1
  ${StrStr} $2 $1 "${APP_EXE}"
  ${If} $2 != ""
    MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION "$(AppRunning)" IDRETRY check_process IDCANCEL cancel_install
  ${EndIf}
  Return

cancel_install:
  Abort
FunctionEnd

Section "ReqHub" SecReqHub
  SectionIn RO
  Call EnsureReqHubClosed

  SetRegView 64
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  File /r "${BUILD_DIR}\*"
  ; Keep a dedicated icon file so shortcuts do not depend on the Windows EXE icon cache.
  File "${APP_ICON}"

  FileOpen $0 "$INSTDIR\.reqhub-install" w
  FileWrite $0 "ReqHub ${APP_VERSION}$\r$\n"
  FileClose $0

  WriteUninstaller "$INSTDIR\Uninstall.exe"

  CreateDirectory "$SMPROGRAMS\ReqHub"
  CreateShortcut "$SMPROGRAMS\ReqHub\ReqHub.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\app_icon.ico" 0
  CreateShortcut "$SMPROGRAMS\ReqHub\Uninstall ReqHub.lnk" "$INSTDIR\Uninstall.exe"

  WriteRegStr HKLM "${APP_REGISTRY_KEY}" "InstallDir" "$INSTDIR"
  WriteRegStr HKLM "${APP_REGISTRY_KEY}" "Version" "${APP_VERSION}"

  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE},0"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "Publisher" "${APP_PUBLISHER}"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "URLInfoAbout" "${APP_URL}"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegStr HKLM "${APP_UNINSTALL_KEY}" "QuietUninstallString" '"$INSTDIR\Uninstall.exe" /S'
  WriteRegDWORD HKLM "${APP_UNINSTALL_KEY}" "NoModify" 1
  WriteRegDWORD HKLM "${APP_UNINSTALL_KEY}" "NoRepair" 1

  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "${APP_UNINSTALL_KEY}" "EstimatedSize" "$0"
SectionEnd

Section /o "$(DesktopShortcut)" SecDesktopShortcut
  SetShellVarContext all
  CreateShortcut "$DESKTOP\ReqHub.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\app_icon.ico" 0
SectionEnd

Function un.onInit
  SetRegView 64
  SetShellVarContext all
FunctionEnd

Function un.EnsureReqHubClosed
check_process:
  nsExec::ExecToStack '"$SYSDIR\tasklist.exe" /FI "IMAGENAME eq ${APP_EXE}" /NH'
  Pop $0
  Pop $1
  ${UnStrStr} $2 $1 "${APP_EXE}"
  ${If} $2 != ""
    MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION "$(AppRunning)" IDRETRY check_process IDCANCEL cancel_uninstall
  ${EndIf}
  Return

cancel_uninstall:
  Abort
FunctionEnd

Section "Uninstall"
  Call un.EnsureReqHubClosed

  SetRegView 64
  SetShellVarContext all

  IfFileExists "$INSTDIR\.reqhub-install" marker_found
  MessageBox MB_OK|MB_ICONSTOP "$(InvalidUninstallDirectory)"
  Abort

marker_found:

  Delete "$DESKTOP\ReqHub.lnk"
  RMDir /r "$SMPROGRAMS\ReqHub"

  DeleteRegKey HKLM "${APP_UNINSTALL_KEY}"
  DeleteRegKey HKLM "${APP_REGISTRY_KEY}"

  ; Remove only files installed by ReqHub so a custom/shared destination is safe.
  Delete "$INSTDIR\reqhub.exe"
  Delete "$INSTDIR\dartjni.dll"
  Delete "$INSTDIR\file_selector_windows_plugin.dll"
  Delete "$INSTDIR\flutter_windows.dll"
  Delete "$INSTDIR\url_launcher_windows_plugin.dll"
  Delete "$INSTDIR\native_assets.json"
  Delete "$INSTDIR\app_icon.ico"
  RMDir /r "$INSTDIR\data"
  Delete "$INSTDIR\.reqhub-install"
  Delete "$INSTDIR\Uninstall.exe"

  ; User data in %APPDATA%\ReqHub is intentionally preserved. The install
  ; directory is removed only when no unrelated files remain.
  RMDir "$INSTDIR"
SectionEnd
