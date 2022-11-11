// ignore_for_file: avoid_dynamic_calls

import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

class Categories {
  const Categories({
    required this.items,
    required this.hasMore,
    required this.nextCursor,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    final items = (json['results'] as List<dynamic>)
        .map(
          (dynamic item) => Category.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return Categories(
      items: items,
      hasMore: json['has_more'] as bool,
      nextCursor: json['next_cursor'] as String?,
    );
  }

  final List<Category> items;
  final bool hasMore;
  final String? nextCursor;
}

@JsonSerializable()
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(readValue: _readNameValue, toJson: _toJsonNameValue)
  final String name;
  final IconItem? icon;

  static String _readNameValue(Map<dynamic, dynamic> json, String _) {
    return json['properties']['Name']['title'][0]['text']['content'] as String;
  }

  Category copyWith({
    String? Function()? idFunction,
    String? name,
    IconItem? Function()? iconFunction,
  }) =>
      Category(
        id: idFunction != null ? idFunction() : id,
        name: name ?? this.name,
        icon: iconFunction != null ? iconFunction() : icon,
      );
  static const empty = Category(
    id: null,
    name: '',
    icon: null,
  );

  static Map<String, dynamic> _toJsonNameValue(String value) {
    return {
      'properties': {
        'Name': {
          'title': [
            {
              'text': {
                'content': value,
              }
            }
          ]
        }
      }
    };
  }
}

@JsonSerializable()
class IconItem {
  const IconItem({required this.iconType, this.emoji, this.externalUrl});

  factory IconItem.fromJson(Map<String, dynamic> json) =>
      _$IconItemFromJson(json);

  Map<String, dynamic> toJson() => _$IconItemToJson(this);

  @JsonKey(unknownEnumValue: IconType.unknown, name: 'type')
  final IconType iconType;

  @JsonKey(includeIfNull: false)
  final String? emoji;

  @JsonKey(includeIfNull: false, name: 'external')
  final ExternalUrl? externalUrl;
}

@JsonEnum(
  valueField: 'type',
)
enum IconType {
  emoji('emoji'),
  externalResource('external'),
  unknown('unknown');

  const IconType(this.type);

  final String type;
}

@JsonSerializable()
class ExternalUrl {
  const ExternalUrl(this.url);

  factory ExternalUrl.fromJson(Map<String, dynamic> json) =>
      _$ExternalUrlFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalUrlToJson(this);

  final String url;
}
