import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// Application window title
  ///
  /// In en, this message translates to:
  /// **'ReqHub'**
  String get app_title;

  /// Dialog title: unsaved changes on app exit
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get app_exit_title;

  /// Exit dialog body. {unsavedCount} is the number of dirty tabs
  ///
  /// In en, this message translates to:
  /// **'You have {unsavedCount} unsaved request(s). Save before exiting?'**
  String app_exit_message(Object unsavedCount);

  /// Button: save all dirty tabs then exit
  ///
  /// In en, this message translates to:
  /// **'Save All & Exit'**
  String get app_exit_save_all;

  /// Button: exit without saving dirty tabs
  ///
  /// In en, this message translates to:
  /// **'Exit Without Saving'**
  String get app_exit_exit_without;

  /// Dialog title: unsaved changes when closing a tab
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get main_unsaved_title;

  /// Close-tab confirmation. {requestName} is the tab label
  ///
  /// In en, this message translates to:
  /// **'“{requestName}” has unsaved changes. Do you want to save before closing?'**
  String main_unsaved_message(Object requestName);

  /// Button: save and close tab
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get main_unsaved_save;

  /// Button: discard changes and close tab
  ///
  /// In en, this message translates to:
  /// **'Don\'t Save'**
  String get main_unsaved_dont_save;

  /// Generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// Generic save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get button_save;

  /// Generic import button
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get button_import;

  /// Empty state when no request is selected
  ///
  /// In en, this message translates to:
  /// **'Select a request or create a new one'**
  String get main_placeholder;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Section header: data storage location
  ///
  /// In en, this message translates to:
  /// **'Data Storage'**
  String get settings_data_storage;

  /// Label: storage path setting
  ///
  /// In en, this message translates to:
  /// **'Storage Path'**
  String get settings_storage_path;

  /// Button: change storage path
  ///
  /// In en, this message translates to:
  /// **'Change...'**
  String get settings_change;

  /// Button: export collections to JSON file
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settings_export_data;

  /// Button: import collections from JSON file
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get settings_import_data;

  /// Section header: appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// Description text for appearance section
  ///
  /// In en, this message translates to:
  /// **'Customize theme and language'**
  String get settings_appearance_desc;

  /// Label: theme mode selector
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// Label: language selector
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// Label: theme color picker
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get settings_theme_color;

  /// Section header: request defaults
  ///
  /// In en, this message translates to:
  /// **'Request Settings'**
  String get settings_request_settings;

  /// Description text for request settings section
  ///
  /// In en, this message translates to:
  /// **'Default HTTP request settings'**
  String get settings_request_desc;

  /// Label: timeout value input
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get settings_timeout;

  /// Label: follow redirects toggle
  ///
  /// In en, this message translates to:
  /// **'Follow redirects'**
  String get settings_follow_redirects;

  /// Label: SSL verification toggle
  ///
  /// In en, this message translates to:
  /// **'SSL verification'**
  String get settings_ssl_verification;

  /// Description text for storage section
  ///
  /// In en, this message translates to:
  /// **'Manage data storage location'**
  String get settings_storage_desc;

  /// Section header: data statistics
  ///
  /// In en, this message translates to:
  /// **'Data Summary'**
  String get settings_data_summary;

  /// Shows total collection count. {count} is a number
  ///
  /// In en, this message translates to:
  /// **'Collections: {count}'**
  String settings_collections_count(Object count);

  /// Dialog title: change storage folder
  ///
  /// In en, this message translates to:
  /// **'Change Storage Path'**
  String get settings_change_path_title;

  /// Placeholder: new storage path input
  ///
  /// In en, this message translates to:
  /// **'Enter new storage path...'**
  String get settings_change_path_hint;

  /// Snackbar: export succeeded. {path} is the file path
  ///
  /// In en, this message translates to:
  /// **'Data exported to: {path}'**
  String settings_exported_to(Object path);

  /// Snackbar: export error. {error} is the exception text
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String settings_export_failed(Object error);

  /// Dialog title: import data
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get settings_import_title;

  /// Placeholder: import file path input
  ///
  /// In en, this message translates to:
  /// **'Enter file path to import...'**
  String get settings_import_hint;

  /// Snackbar: import succeeded
  ///
  /// In en, this message translates to:
  /// **'Data imported successfully.'**
  String get settings_imported_success;

  /// Snackbar: import error. {error} is the exception text
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String settings_import_failed(Object error);

  /// Light theme display name
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// Dark theme display name
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// System-follow theme display name
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get theme_system;

  /// Request editor tab: query parameters
  ///
  /// In en, this message translates to:
  /// **'Params'**
  String get request_tab_params;

  /// Request editor tab: authorization
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
  String get request_tab_auth;

  /// Request editor tab: HTTP headers
  ///
  /// In en, this message translates to:
  /// **'Headers'**
  String get request_tab_headers;

  /// Request editor tab: request body
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get request_tab_body;

  /// Empty state: no response yet
  ///
  /// In en, this message translates to:
  /// **'Hit Send to get a response'**
  String get response_placeholder;

  /// Shown when request produces an error. {error} is the exception
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String response_error(Object error);

  /// Response pane tab: response body
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get response_tab_body;

  /// Response pane tab: response headers
  ///
  /// In en, this message translates to:
  /// **'Headers'**
  String get response_tab_headers;

  /// Response pane tab: cookies
  ///
  /// In en, this message translates to:
  /// **'Cookies'**
  String get response_tab_cookies;

  /// Empty state: no cookies in response
  ///
  /// In en, this message translates to:
  /// **'No cookies received'**
  String get response_no_cookies;

  /// Empty state: no headers in response
  ///
  /// In en, this message translates to:
  /// **'No headers received'**
  String get response_no_headers;

  /// Dialog title: import from cURL
  ///
  /// In en, this message translates to:
  /// **'Import cURL'**
  String get sidebar_import_curl_title;

  /// Placeholder: cURL command paste area
  ///
  /// In en, this message translates to:
  /// **'Paste your curl command here...'**
  String get sidebar_import_curl_hint;

  /// Snackbar: cURL imported successfully
  ///
  /// In en, this message translates to:
  /// **'cURL imported successfully.'**
  String get sidebar_curl_success;

  /// Inline error: the pasted text is not a valid curl command
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid cURL command'**
  String get sidebar_curl_invalid;

  /// Snackbar: cURL parse failed. {error} is the parse error
  ///
  /// In en, this message translates to:
  /// **'Failed to parse cURL: {error}'**
  String sidebar_curl_failed(Object error);

  /// Link text: open settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get sidebar_settings;

  /// Flyout menu item: import from cURL
  ///
  /// In en, this message translates to:
  /// **'Import from cURL'**
  String get sidebar_import_from_curl;

  /// Context menu: create new request
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get context_new_request;

  /// Context menu: create new collection
  ///
  /// In en, this message translates to:
  /// **'New Collection'**
  String get context_new_collection;

  /// Context menu: export request as cURL
  ///
  /// In en, this message translates to:
  /// **'Export as cURL'**
  String get context_export_curl;

  /// Context menu: duplicate selected item
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get context_duplicate;

  /// Context menu: rename selected item
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get context_rename;

  /// Context menu: delete selected item
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get context_delete;

  /// Label: auth type selector
  ///
  /// In en, this message translates to:
  /// **'Auth Type: '**
  String get auth_type_label;

  /// Label: basic auth username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get auth_username;

  /// Label: basic auth password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// Label: bearer auth token field
  ///
  /// In en, this message translates to:
  /// **'Token'**
  String get auth_token;

  /// Placeholder: bearer token input
  ///
  /// In en, this message translates to:
  /// **'Enter bearer token...'**
  String get auth_token_hint;

  /// Label: where to add API key (header vs query)
  ///
  /// In en, this message translates to:
  /// **'Add to: '**
  String get auth_add_to;

  /// Label: API key name field
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get auth_key;

  /// Label: API key value field
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get auth_value;

  /// Placeholder: no auth configured
  ///
  /// In en, this message translates to:
  /// **'This request does not use authorization'**
  String get auth_no_auth;

  /// Label: body type selector
  ///
  /// In en, this message translates to:
  /// **'Body Type: '**
  String get body_type_label;

  /// Placeholder: raw body text editor
  ///
  /// In en, this message translates to:
  /// **'Enter raw body...'**
  String get body_raw_hint;

  /// Placeholder: JSON body editor
  ///
  /// In en, this message translates to:
  /// **'[\n  \"key\": \"value\"\n]'**
  String get body_json_hint;

  /// Placeholder: binary file body
  ///
  /// In en, this message translates to:
  /// **'Binary file selection (drag & drop or browse)'**
  String get body_binary_hint;

  /// Placeholder: no body configured
  ///
  /// In en, this message translates to:
  /// **'This request does not have a body'**
  String get body_no_body;

  /// Button: add key-value entry in form body editor
  ///
  /// In en, this message translates to:
  /// **'+ Add Entry'**
  String get body_add_entry;

  /// Column header: key in key-value body table
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get body_key_header;

  /// Column header: value in key-value body table
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get body_value_header;

  /// Column header: query param key
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get params_key_header;

  /// Column header: query param value
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get params_value_header;

  /// Column header: query param description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get params_desc_header;

  /// Button: add a query parameter row
  ///
  /// In en, this message translates to:
  /// **'+ Add Parameter'**
  String get params_add;

  /// Column header: HTTP header name
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get headers_key_header;

  /// Column header: HTTP header value
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get headers_value_header;

  /// Column header: HTTP header description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get headers_desc_header;

  /// Button: add a header row
  ///
  /// In en, this message translates to:
  /// **'+ Add Header'**
  String get headers_add;

  /// Placeholder: URL input field
  ///
  /// In en, this message translates to:
  /// **'Request URL'**
  String get url_placeholder;

  /// Button: send the HTTP request
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get url_send;

  /// Empty state: no request selected in editor area
  ///
  /// In en, this message translates to:
  /// **'Select a request or create a new one'**
  String get request_placeholder;

  /// Tooltip: hide sidebar button in activity bar
  ///
  /// In en, this message translates to:
  /// **'Hide Sidebar'**
  String get activity_hide_sidebar;

  /// Tooltip: show sidebar button in activity bar
  ///
  /// In en, this message translates to:
  /// **'Show Sidebar'**
  String get activity_show_sidebar;

  /// Tooltip: settings button in activity bar
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get activity_settings;

  /// Default name for a newly created request
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get default_request_name;

  /// Default name for a newly created collection
  ///
  /// In en, this message translates to:
  /// **'New Collection'**
  String get default_collection_name;

  /// Display label for English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_en;

  /// Display label for Chinese language option
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get language_zh;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
