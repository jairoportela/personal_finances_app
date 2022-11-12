// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      name: Category._readNameValue(json, 'properties') as String,
      icon: json['icon'] == null
          ? null
          : IconItem.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['properties'] = Category._toJsonNameValue(instance.name);
  val['icon'] = instance.icon;
  return val;
}

IconItem _$IconItemFromJson(Map<String, dynamic> json) => IconItem(
      iconType: $enumDecode(_$IconTypeEnumMap, json['type'],
          unknownValue: IconType.unknown),
      emoji: json['emoji'] as String?,
      externalUrl: json['external'] == null
          ? null
          : ExternalUrl.fromJson(json['external'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IconItemToJson(IconItem instance) {
  final val = <String, dynamic>{
    'type': _$IconTypeEnumMap[instance.iconType]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('emoji', instance.emoji);
  writeNotNull('external', instance.externalUrl);
  return val;
}

const _$IconTypeEnumMap = {
  IconType.emoji: 'emoji',
  IconType.externalResource: 'external',
  IconType.unknown: 'unknown',
};

ExternalUrl _$ExternalUrlFromJson(Map<String, dynamic> json) => ExternalUrl(
      json['url'] as String,
    );

Map<String, dynamic> _$ExternalUrlToJson(ExternalUrl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
