// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_value_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KeyValuePair _$KeyValuePairFromJson(Map<String, dynamic> json) {
  return _KeyValuePair.fromJson(json);
}

/// @nodoc
mixin _$KeyValuePair {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this KeyValuePair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyValuePair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyValuePairCopyWith<KeyValuePair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyValuePairCopyWith<$Res> {
  factory $KeyValuePairCopyWith(
    KeyValuePair value,
    $Res Function(KeyValuePair) then,
  ) = _$KeyValuePairCopyWithImpl<$Res, KeyValuePair>;
  @useResult
  $Res call({String key, String value, bool enabled, String? description});
}

/// @nodoc
class _$KeyValuePairCopyWithImpl<$Res, $Val extends KeyValuePair>
    implements $KeyValuePairCopyWith<$Res> {
  _$KeyValuePairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyValuePair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? enabled = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeyValuePairImplCopyWith<$Res>
    implements $KeyValuePairCopyWith<$Res> {
  factory _$$KeyValuePairImplCopyWith(
    _$KeyValuePairImpl value,
    $Res Function(_$KeyValuePairImpl) then,
  ) = __$$KeyValuePairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value, bool enabled, String? description});
}

/// @nodoc
class __$$KeyValuePairImplCopyWithImpl<$Res>
    extends _$KeyValuePairCopyWithImpl<$Res, _$KeyValuePairImpl>
    implements _$$KeyValuePairImplCopyWith<$Res> {
  __$$KeyValuePairImplCopyWithImpl(
    _$KeyValuePairImpl _value,
    $Res Function(_$KeyValuePairImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeyValuePair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? enabled = null,
    Object? description = freezed,
  }) {
    return _then(
      _$KeyValuePairImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyValuePairImpl implements _KeyValuePair {
  const _$KeyValuePairImpl({
    required this.key,
    required this.value,
    this.enabled = false,
    this.description,
  });

  factory _$KeyValuePairImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyValuePairImplFromJson(json);

  @override
  final String key;
  @override
  final String value;
  @override
  @JsonKey()
  final bool enabled;
  @override
  final String? description;

  @override
  String toString() {
    return 'KeyValuePair(key: $key, value: $value, enabled: $enabled, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyValuePairImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, key, value, enabled, description);

  /// Create a copy of KeyValuePair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyValuePairImplCopyWith<_$KeyValuePairImpl> get copyWith =>
      __$$KeyValuePairImplCopyWithImpl<_$KeyValuePairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyValuePairImplToJson(this);
  }
}

abstract class _KeyValuePair implements KeyValuePair {
  const factory _KeyValuePair({
    required final String key,
    required final String value,
    final bool enabled,
    final String? description,
  }) = _$KeyValuePairImpl;

  factory _KeyValuePair.fromJson(Map<String, dynamic> json) =
      _$KeyValuePairImpl.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  bool get enabled;
  @override
  String? get description;

  /// Create a copy of KeyValuePair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyValuePairImplCopyWith<_$KeyValuePairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
