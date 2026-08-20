import 'package:freezed_annotation/freezed_annotation.dart';
import 'key_value_pair.dart';

part 'request_body.freezed.dart';
part 'request_body.g.dart';

@freezed
sealed class RequestBody with _$RequestBody {
  const factory RequestBody.none() = NoneBody;

  const factory RequestBody.json({@Default('') String raw}) = JsonBody;

  const factory RequestBody.formData({@Default([]) List<FormField> fields}) =
      FormDataBody;

  const factory RequestBody.urlEncoded({
    @Default([]) List<KeyValuePair> params,
  }) = UrlEncodedBody;

  const factory RequestBody.raw({
    @Default('text/plain') String contentType,
    @Default('') String content,
  }) = RawBody;

  const factory RequestBody.binary({@Default('') String filePath}) = BinaryBody;

  factory RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestBodyFromJson(json);
}

@freezed
class FormField with _$FormField {
  const factory FormField({
    required String key,
    @Default('') String value,
    @Default(FormFieldType.text) FormFieldType type,
    @Default('') String filePath,
  }) = _FormField;

  factory FormField.fromJson(Map<String, dynamic> json) =>
      _$FormFieldFromJson(json);
}

enum FormFieldType { text, file }
