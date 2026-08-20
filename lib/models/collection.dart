import 'package:freezed_annotation/freezed_annotation.dart';
import 'http_request.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String id,
    required String name,
    @Default([]) List<Collection> children,
    @Default([]) List<HttpRequestModel> requests,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
