// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'none':
      return NoneBody.fromJson(json);
    case 'json':
      return JsonBody.fromJson(json);
    case 'formData':
      return FormDataBody.fromJson(json);
    case 'urlEncoded':
      return UrlEncodedBody.fromJson(json);
    case 'raw':
      return RawBody.fromJson(json);
    case 'binary':
      return BinaryBody.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'RequestBody',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$RequestBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this RequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestBodyCopyWith<$Res> {
  factory $RequestBodyCopyWith(
    RequestBody value,
    $Res Function(RequestBody) then,
  ) = _$RequestBodyCopyWithImpl<$Res, RequestBody>;
}

/// @nodoc
class _$RequestBodyCopyWithImpl<$Res, $Val extends RequestBody>
    implements $RequestBodyCopyWith<$Res> {
  _$RequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NoneBodyImplCopyWith<$Res> {
  factory _$$NoneBodyImplCopyWith(
    _$NoneBodyImpl value,
    $Res Function(_$NoneBodyImpl) then,
  ) = __$$NoneBodyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$NoneBodyImpl>
    implements _$$NoneBodyImplCopyWith<$Res> {
  __$$NoneBodyImplCopyWithImpl(
    _$NoneBodyImpl _value,
    $Res Function(_$NoneBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$NoneBodyImpl implements NoneBody {
  const _$NoneBodyImpl({final String? $type}) : $type = $type ?? 'none';

  factory _$NoneBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoneBodyImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoneBodyImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NoneBodyImplToJson(this);
  }
}

abstract class NoneBody implements RequestBody {
  const factory NoneBody() = _$NoneBodyImpl;

  factory NoneBody.fromJson(Map<String, dynamic> json) =
      _$NoneBodyImpl.fromJson;
}

/// @nodoc
abstract class _$$JsonBodyImplCopyWith<$Res> {
  factory _$$JsonBodyImplCopyWith(
    _$JsonBodyImpl value,
    $Res Function(_$JsonBodyImpl) then,
  ) = __$$JsonBodyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String raw});
}

/// @nodoc
class __$$JsonBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$JsonBodyImpl>
    implements _$$JsonBodyImplCopyWith<$Res> {
  __$$JsonBodyImplCopyWithImpl(
    _$JsonBodyImpl _value,
    $Res Function(_$JsonBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? raw = null}) {
    return _then(
      _$JsonBodyImpl(
        raw: null == raw
            ? _value.raw
            : raw // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JsonBodyImpl implements JsonBody {
  const _$JsonBodyImpl({this.raw = '', final String? $type})
    : $type = $type ?? 'json';

  factory _$JsonBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$JsonBodyImplFromJson(json);

  @override
  @JsonKey()
  final String raw;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.json(raw: $raw)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonBodyImpl &&
            (identical(other.raw, raw) || other.raw == raw));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, raw);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonBodyImplCopyWith<_$JsonBodyImpl> get copyWith =>
      __$$JsonBodyImplCopyWithImpl<_$JsonBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return json(this.raw);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return json?.call(this.raw);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(this.raw);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return json(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return json?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (json != null) {
      return json(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JsonBodyImplToJson(this);
  }
}

abstract class JsonBody implements RequestBody {
  const factory JsonBody({final String raw}) = _$JsonBodyImpl;

  factory JsonBody.fromJson(Map<String, dynamic> json) =
      _$JsonBodyImpl.fromJson;

  String get raw;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JsonBodyImplCopyWith<_$JsonBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FormDataBodyImplCopyWith<$Res> {
  factory _$$FormDataBodyImplCopyWith(
    _$FormDataBodyImpl value,
    $Res Function(_$FormDataBodyImpl) then,
  ) = __$$FormDataBodyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FormField> fields});
}

/// @nodoc
class __$$FormDataBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$FormDataBodyImpl>
    implements _$$FormDataBodyImplCopyWith<$Res> {
  __$$FormDataBodyImplCopyWithImpl(
    _$FormDataBodyImpl _value,
    $Res Function(_$FormDataBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fields = null}) {
    return _then(
      _$FormDataBodyImpl(
        fields: null == fields
            ? _value._fields
            : fields // ignore: cast_nullable_to_non_nullable
                  as List<FormField>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FormDataBodyImpl implements FormDataBody {
  const _$FormDataBodyImpl({
    final List<FormField> fields = const [],
    final String? $type,
  }) : _fields = fields,
       $type = $type ?? 'formData';

  factory _$FormDataBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormDataBodyImplFromJson(json);

  final List<FormField> _fields;
  @override
  @JsonKey()
  List<FormField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.formData(fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormDataBodyImpl &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_fields));

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormDataBodyImplCopyWith<_$FormDataBodyImpl> get copyWith =>
      __$$FormDataBodyImplCopyWithImpl<_$FormDataBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return formData(fields);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return formData?.call(fields);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (formData != null) {
      return formData(fields);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return formData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return formData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (formData != null) {
      return formData(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FormDataBodyImplToJson(this);
  }
}

abstract class FormDataBody implements RequestBody {
  const factory FormDataBody({final List<FormField> fields}) =
      _$FormDataBodyImpl;

  factory FormDataBody.fromJson(Map<String, dynamic> json) =
      _$FormDataBodyImpl.fromJson;

  List<FormField> get fields;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormDataBodyImplCopyWith<_$FormDataBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UrlEncodedBodyImplCopyWith<$Res> {
  factory _$$UrlEncodedBodyImplCopyWith(
    _$UrlEncodedBodyImpl value,
    $Res Function(_$UrlEncodedBodyImpl) then,
  ) = __$$UrlEncodedBodyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<KeyValuePair> params});
}

/// @nodoc
class __$$UrlEncodedBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$UrlEncodedBodyImpl>
    implements _$$UrlEncodedBodyImplCopyWith<$Res> {
  __$$UrlEncodedBodyImplCopyWithImpl(
    _$UrlEncodedBodyImpl _value,
    $Res Function(_$UrlEncodedBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? params = null}) {
    return _then(
      _$UrlEncodedBodyImpl(
        params: null == params
            ? _value._params
            : params // ignore: cast_nullable_to_non_nullable
                  as List<KeyValuePair>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlEncodedBodyImpl implements UrlEncodedBody {
  const _$UrlEncodedBodyImpl({
    final List<KeyValuePair> params = const [],
    final String? $type,
  }) : _params = params,
       $type = $type ?? 'urlEncoded';

  factory _$UrlEncodedBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlEncodedBodyImplFromJson(json);

  final List<KeyValuePair> _params;
  @override
  @JsonKey()
  List<KeyValuePair> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.urlEncoded(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlEncodedBodyImpl &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_params));

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlEncodedBodyImplCopyWith<_$UrlEncodedBodyImpl> get copyWith =>
      __$$UrlEncodedBodyImplCopyWithImpl<_$UrlEncodedBodyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return urlEncoded(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return urlEncoded?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (urlEncoded != null) {
      return urlEncoded(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return urlEncoded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return urlEncoded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (urlEncoded != null) {
      return urlEncoded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlEncodedBodyImplToJson(this);
  }
}

abstract class UrlEncodedBody implements RequestBody {
  const factory UrlEncodedBody({final List<KeyValuePair> params}) =
      _$UrlEncodedBodyImpl;

  factory UrlEncodedBody.fromJson(Map<String, dynamic> json) =
      _$UrlEncodedBodyImpl.fromJson;

  List<KeyValuePair> get params;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UrlEncodedBodyImplCopyWith<_$UrlEncodedBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RawBodyImplCopyWith<$Res> {
  factory _$$RawBodyImplCopyWith(
    _$RawBodyImpl value,
    $Res Function(_$RawBodyImpl) then,
  ) = __$$RawBodyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contentType, String content});
}

/// @nodoc
class __$$RawBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$RawBodyImpl>
    implements _$$RawBodyImplCopyWith<$Res> {
  __$$RawBodyImplCopyWithImpl(
    _$RawBodyImpl _value,
    $Res Function(_$RawBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contentType = null, Object? content = null}) {
    return _then(
      _$RawBodyImpl(
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RawBodyImpl implements RawBody {
  const _$RawBodyImpl({
    this.contentType = 'text/plain',
    this.content = '',
    final String? $type,
  }) : $type = $type ?? 'raw';

  factory _$RawBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RawBodyImplFromJson(json);

  @override
  @JsonKey()
  final String contentType;
  @override
  @JsonKey()
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.raw(contentType: $contentType, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawBodyImpl &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentType, content);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RawBodyImplCopyWith<_$RawBodyImpl> get copyWith =>
      __$$RawBodyImplCopyWithImpl<_$RawBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return raw(contentType, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return raw?.call(contentType, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (raw != null) {
      return raw(contentType, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return raw(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return raw?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (raw != null) {
      return raw(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RawBodyImplToJson(this);
  }
}

abstract class RawBody implements RequestBody {
  const factory RawBody({final String contentType, final String content}) =
      _$RawBodyImpl;

  factory RawBody.fromJson(Map<String, dynamic> json) = _$RawBodyImpl.fromJson;

  String get contentType;
  String get content;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RawBodyImplCopyWith<_$RawBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BinaryBodyImplCopyWith<$Res> {
  factory _$$BinaryBodyImplCopyWith(
    _$BinaryBodyImpl value,
    $Res Function(_$BinaryBodyImpl) then,
  ) = __$$BinaryBodyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String filePath});
}

/// @nodoc
class __$$BinaryBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$BinaryBodyImpl>
    implements _$$BinaryBodyImplCopyWith<$Res> {
  __$$BinaryBodyImplCopyWithImpl(
    _$BinaryBodyImpl _value,
    $Res Function(_$BinaryBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filePath = null}) {
    return _then(
      _$BinaryBodyImpl(
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BinaryBodyImpl implements BinaryBody {
  const _$BinaryBodyImpl({this.filePath = '', final String? $type})
    : $type = $type ?? 'binary';

  factory _$BinaryBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinaryBodyImplFromJson(json);

  @override
  @JsonKey()
  final String filePath;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RequestBody.binary(filePath: $filePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinaryBodyImpl &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filePath);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BinaryBodyImplCopyWith<_$BinaryBodyImpl> get copyWith =>
      __$$BinaryBodyImplCopyWithImpl<_$BinaryBodyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String raw) json,
    required TResult Function(List<FormField> fields) formData,
    required TResult Function(List<KeyValuePair> params) urlEncoded,
    required TResult Function(String contentType, String content) raw,
    required TResult Function(String filePath) binary,
  }) {
    return binary(filePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String raw)? json,
    TResult? Function(List<FormField> fields)? formData,
    TResult? Function(List<KeyValuePair> params)? urlEncoded,
    TResult? Function(String contentType, String content)? raw,
    TResult? Function(String filePath)? binary,
  }) {
    return binary?.call(filePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String raw)? json,
    TResult Function(List<FormField> fields)? formData,
    TResult Function(List<KeyValuePair> params)? urlEncoded,
    TResult Function(String contentType, String content)? raw,
    TResult Function(String filePath)? binary,
    required TResult orElse(),
  }) {
    if (binary != null) {
      return binary(filePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoneBody value) none,
    required TResult Function(JsonBody value) json,
    required TResult Function(FormDataBody value) formData,
    required TResult Function(UrlEncodedBody value) urlEncoded,
    required TResult Function(RawBody value) raw,
    required TResult Function(BinaryBody value) binary,
  }) {
    return binary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoneBody value)? none,
    TResult? Function(JsonBody value)? json,
    TResult? Function(FormDataBody value)? formData,
    TResult? Function(UrlEncodedBody value)? urlEncoded,
    TResult? Function(RawBody value)? raw,
    TResult? Function(BinaryBody value)? binary,
  }) {
    return binary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoneBody value)? none,
    TResult Function(JsonBody value)? json,
    TResult Function(FormDataBody value)? formData,
    TResult Function(UrlEncodedBody value)? urlEncoded,
    TResult Function(RawBody value)? raw,
    TResult Function(BinaryBody value)? binary,
    required TResult orElse(),
  }) {
    if (binary != null) {
      return binary(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BinaryBodyImplToJson(this);
  }
}

abstract class BinaryBody implements RequestBody {
  const factory BinaryBody({final String filePath}) = _$BinaryBodyImpl;

  factory BinaryBody.fromJson(Map<String, dynamic> json) =
      _$BinaryBodyImpl.fromJson;

  String get filePath;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BinaryBodyImplCopyWith<_$BinaryBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormField _$FormFieldFromJson(Map<String, dynamic> json) {
  return _FormField.fromJson(json);
}

/// @nodoc
mixin _$FormField {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  FormFieldType get type => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;

  /// Serializes this FormField to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormFieldCopyWith<FormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormFieldCopyWith<$Res> {
  factory $FormFieldCopyWith(FormField value, $Res Function(FormField) then) =
      _$FormFieldCopyWithImpl<$Res, FormField>;
  @useResult
  $Res call({String key, String value, FormFieldType type, String filePath});
}

/// @nodoc
class _$FormFieldCopyWithImpl<$Res, $Val extends FormField>
    implements $FormFieldCopyWith<$Res> {
  _$FormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? type = null,
    Object? filePath = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as FormFieldType,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FormFieldImplCopyWith<$Res>
    implements $FormFieldCopyWith<$Res> {
  factory _$$FormFieldImplCopyWith(
    _$FormFieldImpl value,
    $Res Function(_$FormFieldImpl) then,
  ) = __$$FormFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value, FormFieldType type, String filePath});
}

/// @nodoc
class __$$FormFieldImplCopyWithImpl<$Res>
    extends _$FormFieldCopyWithImpl<$Res, _$FormFieldImpl>
    implements _$$FormFieldImplCopyWith<$Res> {
  __$$FormFieldImplCopyWithImpl(
    _$FormFieldImpl _value,
    $Res Function(_$FormFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? type = null,
    Object? filePath = null,
  }) {
    return _then(
      _$FormFieldImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as FormFieldType,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FormFieldImpl implements _FormField {
  const _$FormFieldImpl({
    required this.key,
    this.value = '',
    this.type = FormFieldType.text,
    this.filePath = '',
  });

  factory _$FormFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormFieldImplFromJson(json);

  @override
  final String key;
  @override
  @JsonKey()
  final String value;
  @override
  @JsonKey()
  final FormFieldType type;
  @override
  @JsonKey()
  final String filePath;

  @override
  String toString() {
    return 'FormField(key: $key, value: $value, type: $type, filePath: $filePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormFieldImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, value, type, filePath);

  /// Create a copy of FormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormFieldImplCopyWith<_$FormFieldImpl> get copyWith =>
      __$$FormFieldImplCopyWithImpl<_$FormFieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormFieldImplToJson(this);
  }
}

abstract class _FormField implements FormField {
  const factory _FormField({
    required final String key,
    final String value,
    final FormFieldType type,
    final String filePath,
  }) = _$FormFieldImpl;

  factory _FormField.fromJson(Map<String, dynamic> json) =
      _$FormFieldImpl.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  FormFieldType get type;
  @override
  String get filePath;

  /// Create a copy of FormField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormFieldImplCopyWith<_$FormFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
