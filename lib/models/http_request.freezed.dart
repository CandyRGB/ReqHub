// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HttpRequestModel _$HttpRequestModelFromJson(Map<String, dynamic> json) {
  return _HttpRequestModel.fromJson(json);
}

/// @nodoc
mixin _$HttpRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<KeyValuePair> get headers => throw _privateConstructorUsedError;
  List<KeyValuePair> get queryParams => throw _privateConstructorUsedError;
  RequestBody get body => throw _privateConstructorUsedError;
  AuthConfig? get auth => throw _privateConstructorUsedError;
  String? get collectionId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HttpRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HttpRequestModelCopyWith<HttpRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpRequestModelCopyWith<$Res> {
  factory $HttpRequestModelCopyWith(
    HttpRequestModel value,
    $Res Function(HttpRequestModel) then,
  ) = _$HttpRequestModelCopyWithImpl<$Res, HttpRequestModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String method,
    String url,
    List<KeyValuePair> headers,
    List<KeyValuePair> queryParams,
    RequestBody body,
    AuthConfig? auth,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $RequestBodyCopyWith<$Res> get body;
  $AuthConfigCopyWith<$Res>? get auth;
}

/// @nodoc
class _$HttpRequestModelCopyWithImpl<$Res, $Val extends HttpRequestModel>
    implements $HttpRequestModelCopyWith<$Res> {
  _$HttpRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? method = null,
    Object? url = null,
    Object? headers = null,
    Object? queryParams = null,
    Object? body = null,
    Object? auth = freezed,
    Object? collectionId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            headers: null == headers
                ? _value.headers
                : headers // ignore: cast_nullable_to_non_nullable
                      as List<KeyValuePair>,
            queryParams: null == queryParams
                ? _value.queryParams
                : queryParams // ignore: cast_nullable_to_non_nullable
                      as List<KeyValuePair>,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as RequestBody,
            auth: freezed == auth
                ? _value.auth
                : auth // ignore: cast_nullable_to_non_nullable
                      as AuthConfig?,
            collectionId: freezed == collectionId
                ? _value.collectionId
                : collectionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBodyCopyWith<$Res> get body {
    return $RequestBodyCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthConfigCopyWith<$Res>? get auth {
    if (_value.auth == null) {
      return null;
    }

    return $AuthConfigCopyWith<$Res>(_value.auth!, (value) {
      return _then(_value.copyWith(auth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HttpRequestModelImplCopyWith<$Res>
    implements $HttpRequestModelCopyWith<$Res> {
  factory _$$HttpRequestModelImplCopyWith(
    _$HttpRequestModelImpl value,
    $Res Function(_$HttpRequestModelImpl) then,
  ) = __$$HttpRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String method,
    String url,
    List<KeyValuePair> headers,
    List<KeyValuePair> queryParams,
    RequestBody body,
    AuthConfig? auth,
    String? collectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $RequestBodyCopyWith<$Res> get body;
  @override
  $AuthConfigCopyWith<$Res>? get auth;
}

/// @nodoc
class __$$HttpRequestModelImplCopyWithImpl<$Res>
    extends _$HttpRequestModelCopyWithImpl<$Res, _$HttpRequestModelImpl>
    implements _$$HttpRequestModelImplCopyWith<$Res> {
  __$$HttpRequestModelImplCopyWithImpl(
    _$HttpRequestModelImpl _value,
    $Res Function(_$HttpRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? method = null,
    Object? url = null,
    Object? headers = null,
    Object? queryParams = null,
    Object? body = null,
    Object? auth = freezed,
    Object? collectionId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$HttpRequestModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        headers: null == headers
            ? _value._headers
            : headers // ignore: cast_nullable_to_non_nullable
                  as List<KeyValuePair>,
        queryParams: null == queryParams
            ? _value._queryParams
            : queryParams // ignore: cast_nullable_to_non_nullable
                  as List<KeyValuePair>,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as RequestBody,
        auth: freezed == auth
            ? _value.auth
            : auth // ignore: cast_nullable_to_non_nullable
                  as AuthConfig?,
        collectionId: freezed == collectionId
            ? _value.collectionId
            : collectionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HttpRequestModelImpl implements _HttpRequestModel {
  const _$HttpRequestModelImpl({
    required this.id,
    required this.name,
    this.method = 'GET',
    this.url = '',
    final List<KeyValuePair> headers = const [],
    final List<KeyValuePair> queryParams = const [],
    this.body = const RequestBody.none(),
    this.auth,
    this.collectionId,
    this.createdAt,
    this.updatedAt,
  }) : _headers = headers,
       _queryParams = queryParams;

  factory _$HttpRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HttpRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String method;
  @override
  @JsonKey()
  final String url;
  final List<KeyValuePair> _headers;
  @override
  @JsonKey()
  List<KeyValuePair> get headers {
    if (_headers is EqualUnmodifiableListView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_headers);
  }

  final List<KeyValuePair> _queryParams;
  @override
  @JsonKey()
  List<KeyValuePair> get queryParams {
    if (_queryParams is EqualUnmodifiableListView) return _queryParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queryParams);
  }

  @override
  @JsonKey()
  final RequestBody body;
  @override
  final AuthConfig? auth;
  @override
  final String? collectionId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'HttpRequestModel(id: $id, name: $name, method: $method, url: $url, headers: $headers, queryParams: $queryParams, body: $body, auth: $auth, collectionId: $collectionId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(
              other._queryParams,
              _queryParams,
            ) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.auth, auth) || other.auth == auth) &&
            (identical(other.collectionId, collectionId) ||
                other.collectionId == collectionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    method,
    url,
    const DeepCollectionEquality().hash(_headers),
    const DeepCollectionEquality().hash(_queryParams),
    body,
    auth,
    collectionId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpRequestModelImplCopyWith<_$HttpRequestModelImpl> get copyWith =>
      __$$HttpRequestModelImplCopyWithImpl<_$HttpRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HttpRequestModelImplToJson(this);
  }
}

abstract class _HttpRequestModel implements HttpRequestModel {
  const factory _HttpRequestModel({
    required final String id,
    required final String name,
    final String method,
    final String url,
    final List<KeyValuePair> headers,
    final List<KeyValuePair> queryParams,
    final RequestBody body,
    final AuthConfig? auth,
    final String? collectionId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$HttpRequestModelImpl;

  factory _HttpRequestModel.fromJson(Map<String, dynamic> json) =
      _$HttpRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get method;
  @override
  String get url;
  @override
  List<KeyValuePair> get headers;
  @override
  List<KeyValuePair> get queryParams;
  @override
  RequestBody get body;
  @override
  AuthConfig? get auth;
  @override
  String? get collectionId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of HttpRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HttpRequestModelImplCopyWith<_$HttpRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthConfig _$AuthConfigFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'basic':
      return BasicAuth.fromJson(json);
    case 'bearer':
      return BearerAuth.fromJson(json);
    case 'apiKey':
      return ApiKeyAuth.fromJson(json);
    case 'noAuth':
      return NoAuth.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'AuthConfig',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$AuthConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String password) basic,
    required TResult Function(String token) bearer,
    required TResult Function(String addTo, String key, String value) apiKey,
    required TResult Function() noAuth,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String password)? basic,
    TResult? Function(String token)? bearer,
    TResult? Function(String addTo, String key, String value)? apiKey,
    TResult? Function()? noAuth,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String password)? basic,
    TResult Function(String token)? bearer,
    TResult Function(String addTo, String key, String value)? apiKey,
    TResult Function()? noAuth,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BasicAuth value) basic,
    required TResult Function(BearerAuth value) bearer,
    required TResult Function(ApiKeyAuth value) apiKey,
    required TResult Function(NoAuth value) noAuth,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BasicAuth value)? basic,
    TResult? Function(BearerAuth value)? bearer,
    TResult? Function(ApiKeyAuth value)? apiKey,
    TResult? Function(NoAuth value)? noAuth,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BasicAuth value)? basic,
    TResult Function(BearerAuth value)? bearer,
    TResult Function(ApiKeyAuth value)? apiKey,
    TResult Function(NoAuth value)? noAuth,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this AuthConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthConfigCopyWith<$Res> {
  factory $AuthConfigCopyWith(
    AuthConfig value,
    $Res Function(AuthConfig) then,
  ) = _$AuthConfigCopyWithImpl<$Res, AuthConfig>;
}

/// @nodoc
class _$AuthConfigCopyWithImpl<$Res, $Val extends AuthConfig>
    implements $AuthConfigCopyWith<$Res> {
  _$AuthConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BasicAuthImplCopyWith<$Res> {
  factory _$$BasicAuthImplCopyWith(
    _$BasicAuthImpl value,
    $Res Function(_$BasicAuthImpl) then,
  ) = __$$BasicAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$BasicAuthImplCopyWithImpl<$Res>
    extends _$AuthConfigCopyWithImpl<$Res, _$BasicAuthImpl>
    implements _$$BasicAuthImplCopyWith<$Res> {
  __$$BasicAuthImplCopyWithImpl(
    _$BasicAuthImpl _value,
    $Res Function(_$BasicAuthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? username = null, Object? password = null}) {
    return _then(
      _$BasicAuthImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BasicAuthImpl implements BasicAuth {
  const _$BasicAuthImpl({
    this.username = '',
    this.password = '',
    final String? $type,
  }) : $type = $type ?? 'basic';

  factory _$BasicAuthImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasicAuthImplFromJson(json);

  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String password;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthConfig.basic(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasicAuthImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasicAuthImplCopyWith<_$BasicAuthImpl> get copyWith =>
      __$$BasicAuthImplCopyWithImpl<_$BasicAuthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String password) basic,
    required TResult Function(String token) bearer,
    required TResult Function(String addTo, String key, String value) apiKey,
    required TResult Function() noAuth,
  }) {
    return basic(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String password)? basic,
    TResult? Function(String token)? bearer,
    TResult? Function(String addTo, String key, String value)? apiKey,
    TResult? Function()? noAuth,
  }) {
    return basic?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String password)? basic,
    TResult Function(String token)? bearer,
    TResult Function(String addTo, String key, String value)? apiKey,
    TResult Function()? noAuth,
    required TResult orElse(),
  }) {
    if (basic != null) {
      return basic(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BasicAuth value) basic,
    required TResult Function(BearerAuth value) bearer,
    required TResult Function(ApiKeyAuth value) apiKey,
    required TResult Function(NoAuth value) noAuth,
  }) {
    return basic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BasicAuth value)? basic,
    TResult? Function(BearerAuth value)? bearer,
    TResult? Function(ApiKeyAuth value)? apiKey,
    TResult? Function(NoAuth value)? noAuth,
  }) {
    return basic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BasicAuth value)? basic,
    TResult Function(BearerAuth value)? bearer,
    TResult Function(ApiKeyAuth value)? apiKey,
    TResult Function(NoAuth value)? noAuth,
    required TResult orElse(),
  }) {
    if (basic != null) {
      return basic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BasicAuthImplToJson(this);
  }
}

abstract class BasicAuth implements AuthConfig {
  const factory BasicAuth({final String username, final String password}) =
      _$BasicAuthImpl;

  factory BasicAuth.fromJson(Map<String, dynamic> json) =
      _$BasicAuthImpl.fromJson;

  String get username;
  String get password;

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasicAuthImplCopyWith<_$BasicAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BearerAuthImplCopyWith<$Res> {
  factory _$$BearerAuthImplCopyWith(
    _$BearerAuthImpl value,
    $Res Function(_$BearerAuthImpl) then,
  ) = __$$BearerAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$BearerAuthImplCopyWithImpl<$Res>
    extends _$AuthConfigCopyWithImpl<$Res, _$BearerAuthImpl>
    implements _$$BearerAuthImplCopyWith<$Res> {
  __$$BearerAuthImplCopyWithImpl(
    _$BearerAuthImpl _value,
    $Res Function(_$BearerAuthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _$BearerAuthImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BearerAuthImpl implements BearerAuth {
  const _$BearerAuthImpl({this.token = '', final String? $type})
    : $type = $type ?? 'bearer';

  factory _$BearerAuthImpl.fromJson(Map<String, dynamic> json) =>
      _$$BearerAuthImplFromJson(json);

  @override
  @JsonKey()
  final String token;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthConfig.bearer(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BearerAuthImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BearerAuthImplCopyWith<_$BearerAuthImpl> get copyWith =>
      __$$BearerAuthImplCopyWithImpl<_$BearerAuthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String password) basic,
    required TResult Function(String token) bearer,
    required TResult Function(String addTo, String key, String value) apiKey,
    required TResult Function() noAuth,
  }) {
    return bearer(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String password)? basic,
    TResult? Function(String token)? bearer,
    TResult? Function(String addTo, String key, String value)? apiKey,
    TResult? Function()? noAuth,
  }) {
    return bearer?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String password)? basic,
    TResult Function(String token)? bearer,
    TResult Function(String addTo, String key, String value)? apiKey,
    TResult Function()? noAuth,
    required TResult orElse(),
  }) {
    if (bearer != null) {
      return bearer(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BasicAuth value) basic,
    required TResult Function(BearerAuth value) bearer,
    required TResult Function(ApiKeyAuth value) apiKey,
    required TResult Function(NoAuth value) noAuth,
  }) {
    return bearer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BasicAuth value)? basic,
    TResult? Function(BearerAuth value)? bearer,
    TResult? Function(ApiKeyAuth value)? apiKey,
    TResult? Function(NoAuth value)? noAuth,
  }) {
    return bearer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BasicAuth value)? basic,
    TResult Function(BearerAuth value)? bearer,
    TResult Function(ApiKeyAuth value)? apiKey,
    TResult Function(NoAuth value)? noAuth,
    required TResult orElse(),
  }) {
    if (bearer != null) {
      return bearer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BearerAuthImplToJson(this);
  }
}

abstract class BearerAuth implements AuthConfig {
  const factory BearerAuth({final String token}) = _$BearerAuthImpl;

  factory BearerAuth.fromJson(Map<String, dynamic> json) =
      _$BearerAuthImpl.fromJson;

  String get token;

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BearerAuthImplCopyWith<_$BearerAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiKeyAuthImplCopyWith<$Res> {
  factory _$$ApiKeyAuthImplCopyWith(
    _$ApiKeyAuthImpl value,
    $Res Function(_$ApiKeyAuthImpl) then,
  ) = __$$ApiKeyAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String addTo, String key, String value});
}

/// @nodoc
class __$$ApiKeyAuthImplCopyWithImpl<$Res>
    extends _$AuthConfigCopyWithImpl<$Res, _$ApiKeyAuthImpl>
    implements _$$ApiKeyAuthImplCopyWith<$Res> {
  __$$ApiKeyAuthImplCopyWithImpl(
    _$ApiKeyAuthImpl _value,
    $Res Function(_$ApiKeyAuthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? addTo = null, Object? key = null, Object? value = null}) {
    return _then(
      _$ApiKeyAuthImpl(
        addTo: null == addTo
            ? _value.addTo
            : addTo // ignore: cast_nullable_to_non_nullable
                  as String,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiKeyAuthImpl implements ApiKeyAuth {
  const _$ApiKeyAuthImpl({
    this.addTo = 'header',
    this.key = '',
    this.value = '',
    final String? $type,
  }) : $type = $type ?? 'apiKey';

  factory _$ApiKeyAuthImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiKeyAuthImplFromJson(json);

  @override
  @JsonKey()
  final String addTo;
  // header or query
  @override
  @JsonKey()
  final String key;
  @override
  @JsonKey()
  final String value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthConfig.apiKey(addTo: $addTo, key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiKeyAuthImpl &&
            (identical(other.addTo, addTo) || other.addTo == addTo) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, addTo, key, value);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiKeyAuthImplCopyWith<_$ApiKeyAuthImpl> get copyWith =>
      __$$ApiKeyAuthImplCopyWithImpl<_$ApiKeyAuthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String password) basic,
    required TResult Function(String token) bearer,
    required TResult Function(String addTo, String key, String value) apiKey,
    required TResult Function() noAuth,
  }) {
    return apiKey(addTo, key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String password)? basic,
    TResult? Function(String token)? bearer,
    TResult? Function(String addTo, String key, String value)? apiKey,
    TResult? Function()? noAuth,
  }) {
    return apiKey?.call(addTo, key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String password)? basic,
    TResult Function(String token)? bearer,
    TResult Function(String addTo, String key, String value)? apiKey,
    TResult Function()? noAuth,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey(addTo, key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BasicAuth value) basic,
    required TResult Function(BearerAuth value) bearer,
    required TResult Function(ApiKeyAuth value) apiKey,
    required TResult Function(NoAuth value) noAuth,
  }) {
    return apiKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BasicAuth value)? basic,
    TResult? Function(BearerAuth value)? bearer,
    TResult? Function(ApiKeyAuth value)? apiKey,
    TResult? Function(NoAuth value)? noAuth,
  }) {
    return apiKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BasicAuth value)? basic,
    TResult Function(BearerAuth value)? bearer,
    TResult Function(ApiKeyAuth value)? apiKey,
    TResult Function(NoAuth value)? noAuth,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiKeyAuthImplToJson(this);
  }
}

abstract class ApiKeyAuth implements AuthConfig {
  const factory ApiKeyAuth({
    final String addTo,
    final String key,
    final String value,
  }) = _$ApiKeyAuthImpl;

  factory ApiKeyAuth.fromJson(Map<String, dynamic> json) =
      _$ApiKeyAuthImpl.fromJson;

  String get addTo; // header or query
  String get key;
  String get value;

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiKeyAuthImplCopyWith<_$ApiKeyAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoAuthImplCopyWith<$Res> {
  factory _$$NoAuthImplCopyWith(
    _$NoAuthImpl value,
    $Res Function(_$NoAuthImpl) then,
  ) = __$$NoAuthImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoAuthImplCopyWithImpl<$Res>
    extends _$AuthConfigCopyWithImpl<$Res, _$NoAuthImpl>
    implements _$$NoAuthImplCopyWith<$Res> {
  __$$NoAuthImplCopyWithImpl(
    _$NoAuthImpl _value,
    $Res Function(_$NoAuthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthConfig
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$NoAuthImpl implements NoAuth {
  const _$NoAuthImpl({final String? $type}) : $type = $type ?? 'noAuth';

  factory _$NoAuthImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoAuthImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthConfig.noAuth()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoAuthImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String password) basic,
    required TResult Function(String token) bearer,
    required TResult Function(String addTo, String key, String value) apiKey,
    required TResult Function() noAuth,
  }) {
    return noAuth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String password)? basic,
    TResult? Function(String token)? bearer,
    TResult? Function(String addTo, String key, String value)? apiKey,
    TResult? Function()? noAuth,
  }) {
    return noAuth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String password)? basic,
    TResult Function(String token)? bearer,
    TResult Function(String addTo, String key, String value)? apiKey,
    TResult Function()? noAuth,
    required TResult orElse(),
  }) {
    if (noAuth != null) {
      return noAuth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BasicAuth value) basic,
    required TResult Function(BearerAuth value) bearer,
    required TResult Function(ApiKeyAuth value) apiKey,
    required TResult Function(NoAuth value) noAuth,
  }) {
    return noAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BasicAuth value)? basic,
    TResult? Function(BearerAuth value)? bearer,
    TResult? Function(ApiKeyAuth value)? apiKey,
    TResult? Function(NoAuth value)? noAuth,
  }) {
    return noAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BasicAuth value)? basic,
    TResult Function(BearerAuth value)? bearer,
    TResult Function(ApiKeyAuth value)? apiKey,
    TResult Function(NoAuth value)? noAuth,
    required TResult orElse(),
  }) {
    if (noAuth != null) {
      return noAuth(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NoAuthImplToJson(this);
  }
}

abstract class NoAuth implements AuthConfig {
  const factory NoAuth() = _$NoAuthImpl;

  factory NoAuth.fromJson(Map<String, dynamic> json) = _$NoAuthImpl.fromJson;
}
