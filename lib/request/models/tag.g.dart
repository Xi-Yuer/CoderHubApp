// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  data: Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  total: (json['total'] as num).toInt(),
  list:
      (json['list'] as List<dynamic>)
          .map((e) => TagItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'total': instance.total,
  'list': instance.list,
};

TagItem _$ListElementFromJson(Map<String, dynamic> json) => TagItem(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$TypeEnumMap, json['type']),
  isSystemProvider: json['is_system_provider'] as bool,
  icon: json['icon'] as String,
  usageCount: (json['usage_count'] as num).toInt(),
  createdAt: (json['createdAt'] as num).toInt(),
  updatedAt: (json['updatedAt'] as num).toInt(),
);

Map<String, dynamic> _$ListElementToJson(TagItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$TypeEnumMap[instance.type]!,
  'is_system_provider': instance.isSystemProvider,
  'icon': instance.icon,
  'usage_count': instance.usageCount,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

const _$TypeEnumMap = {Type.ARTICLE: 'article'};
