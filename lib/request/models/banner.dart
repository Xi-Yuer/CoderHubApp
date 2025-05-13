import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class BannerResponse {
  final int code;
  final String message;
  final List<BannerItem> data;

  BannerResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class BannerItem {
  final String id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final int createdAt;
  final int updatedAt;

  BannerItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}