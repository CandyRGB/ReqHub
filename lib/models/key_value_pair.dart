import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_value_pair.freezed.dart';
part 'key_value_pair.g.dart';

@freezed
class KeyValuePair with _$KeyValuePair {
  const factory KeyValuePair({
    required String key,
    required String value,
    @Default(false) bool enabled,
    String? description,
  }) = _KeyValuePair;

  factory KeyValuePair.fromJson(Map<String, dynamic> json) =>
      _$KeyValuePairFromJson(json);
}
