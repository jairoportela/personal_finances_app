// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String,
      name: Category._readNameValue(json, 'name'),
      icon: json['icon'] == null
          ? null
          : IconItem.fromJson(json['icon'] as Map<String, dynamic>),
    );

IconItem _$IconItemFromJson(Map<String, dynamic> json) => IconItem(
      iconType: $enumDecode(
        _$IconTypeEnumMap,
        json['type'],
        unknownValue: IconType.unknown,
      ),
      emoji: json['emoji'] as String?,
      externalUrl: json['external'] == null
          ? null
          : ExternalUrl.fromJson(json['external'] as Map<String, dynamic>),
    );

const _$IconTypeEnumMap = {
  IconType.emoji: 'emoji',
  IconType.externalResource: 'external',
  IconType.unknown: 'unknown',
};

ExternalUrl _$ExternalUrlFromJson(Map<String, dynamic> json) => ExternalUrl(
      json['url'] as String,
    );
