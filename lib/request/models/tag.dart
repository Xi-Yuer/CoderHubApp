import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Tag {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  Data data;

  Tag({required this.code, required this.message, required this.data});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "list")
  List<ListElement> list;

  Data({required this.total, required this.list});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ListElement {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "type")
  Type type;
  @JsonKey(name: "is_system_provider")
  bool isSystemProvider;
  @JsonKey(name: "icon")
  String icon;
  @JsonKey(name: "usage_count")
  int usageCount;
  @JsonKey(name: "createdAt")
  int createdAt;
  @JsonKey(name: "updatedAt")
  int updatedAt;

  ListElement({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.isSystemProvider,
    required this.icon,
    required this.usageCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) =>
      _$ListElementFromJson(json);

  Map<String, dynamic> toJson() => _$ListElementToJson(this);
}

enum Type {
  @JsonValue("article")
  ARTICLE,
}
