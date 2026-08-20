// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'ReqHub';

  @override
  String get app_exit_title => 'Unsaved Changes';

  @override
  String app_exit_message(Object unsavedCount) {
    return 'You have $unsavedCount unsaved request(s). Save before exiting?';
  }

  @override
  String get app_exit_save_all => 'Save All & Exit';

  @override
  String get app_exit_exit_without => 'Exit Without Saving';

  @override
  String get main_unsaved_title => 'Unsaved Changes';

  @override
  String main_unsaved_message(Object requestName) {
    return '“$requestName” has unsaved changes. Do you want to save before closing?';
  }

  @override
  String get main_unsaved_save => 'Save';

  @override
  String get main_unsaved_dont_save => 'Don\'t Save';

  @override
  String get button_cancel => 'Cancel';

  @override
  String get button_save => 'Save';

  @override
  String get button_import => 'Import';

  @override
  String get main_placeholder => 'Select a request or create a new one';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_data_storage => 'Data Storage';

  @override
  String get settings_storage_path => 'Storage Path';

  @override
  String get settings_change => 'Change...';

  @override
  String get settings_export_data => 'Export Data';

  @override
  String get settings_import_data => 'Import Data';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_appearance_desc => 'Customize theme and language';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_theme_color => 'Theme Color';

  @override
  String get settings_request_settings => 'Request Settings';

  @override
  String get settings_request_desc => 'Default HTTP request settings';

  @override
  String get settings_timeout => 'Timeout';

  @override
  String get settings_follow_redirects => 'Follow redirects';

  @override
  String get settings_ssl_verification => 'SSL verification';

  @override
  String get settings_storage_desc => 'Manage data storage location';

  @override
  String get settings_data_summary => 'Data Summary';

  @override
  String settings_collections_count(Object count) {
    return 'Collections: $count';
  }

  @override
  String get settings_change_path_title => 'Change Storage Path';

  @override
  String get settings_change_path_hint => 'Enter new storage path...';

  @override
  String settings_exported_to(Object path) {
    return 'Data exported to: $path';
  }

  @override
  String settings_export_failed(Object error) {
    return 'Export failed: $error';
  }

  @override
  String get settings_import_title => 'Import Data';

  @override
  String get settings_import_hint => 'Enter file path to import...';

  @override
  String get settings_imported_success => 'Data imported successfully.';

  @override
  String settings_import_failed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get theme_system => 'System';

  @override
  String get request_tab_params => 'Params';

  @override
  String get request_tab_auth => 'Authorization';

  @override
  String get request_tab_headers => 'Headers';

  @override
  String get request_tab_body => 'Body';

  @override
  String get response_placeholder => 'Hit Send to get a response';

  @override
  String response_error(Object error) {
    return 'Error: $error';
  }

  @override
  String get response_tab_body => 'Body';

  @override
  String get response_tab_headers => 'Headers';

  @override
  String get response_tab_cookies => 'Cookies';

  @override
  String get response_no_cookies => 'No cookies received';

  @override
  String get response_no_headers => 'No headers received';

  @override
  String get sidebar_import_curl_title => 'Import cURL';

  @override
  String get sidebar_import_curl_hint => 'Paste your curl command here...';

  @override
  String get sidebar_curl_success => 'cURL imported successfully.';

  @override
  String get sidebar_curl_invalid => 'Please enter a valid cURL command';

  @override
  String sidebar_curl_failed(Object error) {
    return 'Failed to parse cURL: $error';
  }

  @override
  String get sidebar_settings => 'Settings';

  @override
  String get sidebar_import_from_curl => 'Import from cURL';

  @override
  String get context_new_request => 'New Request';

  @override
  String get context_new_collection => 'New Collection';

  @override
  String get context_export_curl => 'Export as cURL';

  @override
  String get curl_copied => 'cURL command copied';

  @override
  String get context_duplicate => 'Duplicate';

  @override
  String get context_rename => 'Rename';

  @override
  String get context_delete => 'Delete';

  @override
  String get auth_type_label => 'Auth Type: ';

  @override
  String get auth_username => 'Username';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_token => 'Token';

  @override
  String get auth_token_hint => 'Enter bearer token...';

  @override
  String get auth_add_to => 'Add to: ';

  @override
  String get auth_key => 'Key';

  @override
  String get auth_value => 'Value';

  @override
  String get auth_no_auth => 'This request does not use authorization';

  @override
  String get body_type_label => 'Body Type: ';

  @override
  String get body_raw_hint => 'Enter raw body...';

  @override
  String get body_json_hint => '[\n  \"key\": \"value\"\n]';

  @override
  String get body_binary_hint =>
      'Binary file selection (drag & drop or browse)';

  @override
  String get body_binary_select_file => 'Choose file';

  @override
  String get body_no_body => 'This request does not have a body';

  @override
  String get body_add_entry => '+ Add Entry';

  @override
  String get body_key_header => 'Key';

  @override
  String get body_value_header => 'Value';

  @override
  String get params_key_header => 'Key';

  @override
  String get params_value_header => 'Value';

  @override
  String get params_desc_header => 'Description';

  @override
  String get params_add => '+ Add Parameter';

  @override
  String get headers_key_header => 'Key';

  @override
  String get headers_value_header => 'Value';

  @override
  String get headers_desc_header => 'Description';

  @override
  String get headers_add => '+ Add Header';

  @override
  String get url_placeholder => 'Request URL';

  @override
  String get url_send => 'Send';

  @override
  String get url_required => 'Please enter a request URL';

  @override
  String get request_placeholder => 'Select a request or create a new one';

  @override
  String get activity_hide_sidebar => 'Hide Sidebar';

  @override
  String get activity_show_sidebar => 'Show Sidebar';

  @override
  String get activity_settings => 'Settings';

  @override
  String get default_request_name => 'New Request';

  @override
  String get default_collection_name => 'New Collection';

  @override
  String get language_en => 'English';

  @override
  String get language_zh => '中文';
}
