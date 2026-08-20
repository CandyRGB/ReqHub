// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get app_title => 'ReqHub';

  @override
  String get app_exit_title => '未保存的更改';

  @override
  String app_exit_message(Object unsavedCount) {
    return '您有 $unsavedCount 个未保存的请求。退出前保存吗？';
  }

  @override
  String get app_exit_save_all => '全部保存并退出';

  @override
  String get app_exit_exit_without => '不保存直接退出';

  @override
  String get main_unsaved_title => '未保存的更改';

  @override
  String main_unsaved_message(Object requestName) {
    return '“$requestName” 有未保存的更改。关闭前要保存吗？';
  }

  @override
  String get main_unsaved_save => '保存';

  @override
  String get main_unsaved_dont_save => '不保存';

  @override
  String get button_cancel => '取消';

  @override
  String get button_save => '保存';

  @override
  String get button_import => '导入';

  @override
  String get main_placeholder => '请选择一个请求或新建一个';

  @override
  String get settings_title => '设置';

  @override
  String get settings_data_storage => '数据存储';

  @override
  String get settings_storage_path => '存储路径';

  @override
  String get settings_change => '更改...';

  @override
  String get settings_export_data => '导出数据';

  @override
  String get settings_import_data => '导入数据';

  @override
  String get settings_appearance => '外观';

  @override
  String get settings_appearance_desc => '自定义主题与语言';

  @override
  String get settings_theme => '主题';

  @override
  String get settings_language => '语言';

  @override
  String get settings_theme_color => '主题色';

  @override
  String get settings_request_settings => '请求设置';

  @override
  String get settings_request_desc => 'HTTP 请求的默认设置';

  @override
  String get settings_timeout => '超时';

  @override
  String get settings_follow_redirects => '跟随重定向';

  @override
  String get settings_ssl_verification => 'SSL 验证';

  @override
  String get settings_storage_desc => '管理数据存储位置';

  @override
  String get settings_data_summary => '数据摘要';

  @override
  String settings_collections_count(Object count) {
    return '集合数量：$count';
  }

  @override
  String get settings_change_path_title => '更改存储路径';

  @override
  String get settings_change_path_hint => '输入新的存储路径...';

  @override
  String settings_exported_to(Object path) {
    return '数据已导出到：$path';
  }

  @override
  String settings_export_failed(Object error) {
    return '导出失败：$error';
  }

  @override
  String get settings_import_title => '导入数据';

  @override
  String get settings_import_hint => '输入要导入的文件路径...';

  @override
  String get settings_imported_success => '数据导入成功。';

  @override
  String settings_import_failed(Object error) {
    return '导入失败：$error';
  }

  @override
  String get theme_light => '浅色';

  @override
  String get theme_dark => '深色';

  @override
  String get theme_system => '跟随系统';

  @override
  String get request_tab_params => '参数';

  @override
  String get request_tab_auth => '认证';

  @override
  String get request_tab_headers => '请求头';

  @override
  String get request_tab_body => '请求体';

  @override
  String get response_placeholder => '点击发送以获取响应';

  @override
  String response_error(Object error) {
    return '错误：$error';
  }

  @override
  String get response_tab_body => '响应体';

  @override
  String get response_tab_headers => '响应头';

  @override
  String get response_tab_cookies => 'Cookies';

  @override
  String get response_no_cookies => '未收到 Cookies';

  @override
  String get response_no_headers => '未收到响应头';

  @override
  String get sidebar_import_curl_title => '导入 cURL';

  @override
  String get sidebar_import_curl_hint => '在此粘贴 curl 命令...';

  @override
  String get sidebar_curl_success => 'cURL 导入成功。';

  @override
  String get sidebar_curl_invalid => '请输入正确的 cURL 命令';

  @override
  String sidebar_curl_failed(Object error) {
    return '解析 cURL 失败：$error';
  }

  @override
  String get sidebar_settings => '设置';

  @override
  String get sidebar_import_from_curl => '从 cURL 导入';

  @override
  String get context_new_request => '新建请求';

  @override
  String get context_new_collection => '新建集合';

  @override
  String get context_export_curl => '导出为 cURL';

  @override
  String get context_duplicate => '复制';

  @override
  String get context_rename => '重命名';

  @override
  String get context_delete => '删除';

  @override
  String get auth_type_label => '认证类型：';

  @override
  String get auth_username => '用户名';

  @override
  String get auth_password => '密码';

  @override
  String get auth_token => '令牌';

  @override
  String get auth_token_hint => '输入 Bearer 令牌...';

  @override
  String get auth_add_to => '添加到：';

  @override
  String get auth_key => '键';

  @override
  String get auth_value => '值';

  @override
  String get auth_no_auth => '此请求不使用认证';

  @override
  String get body_type_label => '请求体类型：';

  @override
  String get body_raw_hint => '输入原始请求体...';

  @override
  String get body_json_hint => '[\n  \"键\": \"值\"\n]';

  @override
  String get body_binary_hint => '二进制文件选择（拖放或浏览）';

  @override
  String get body_no_body => '此请求没有请求体';

  @override
  String get body_add_entry => '+ 添加条目';

  @override
  String get body_key_header => '键';

  @override
  String get body_value_header => '值';

  @override
  String get params_key_header => '键';

  @override
  String get params_value_header => '值';

  @override
  String get params_desc_header => '描述';

  @override
  String get params_add => '+ 添加参数';

  @override
  String get headers_key_header => '键';

  @override
  String get headers_value_header => '值';

  @override
  String get headers_desc_header => '描述';

  @override
  String get headers_add => '+ 添加请求头';

  @override
  String get url_placeholder => '请求 url';

  @override
  String get url_send => '发送';

  @override
  String get request_placeholder => '请选择一个请求或新建一个';

  @override
  String get activity_hide_sidebar => '隐藏侧边栏';

  @override
  String get activity_show_sidebar => '显示侧边栏';

  @override
  String get activity_settings => '设置';

  @override
  String get default_request_name => '新建请求';

  @override
  String get default_collection_name => '新建集合';

  @override
  String get language_en => 'English';

  @override
  String get language_zh => '中文';
}
