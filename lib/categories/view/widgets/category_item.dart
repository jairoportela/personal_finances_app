import 'package:flutter/material.dart';
import 'package:personal_finances_app/categories/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.item});

  final Category item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.icon != null
          ? _LeadingIcon(
              icon: item.icon!,
            )
          : null,
      title: Text(item.name),
      onTap: () async {},
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.icon});
  final IconItem icon;
  @override
  Widget build(BuildContext context) {
    return icon.iconType == IconType.externalResource
        ? Image.network(
            icon.externalUrl!.url,
            height: 25,
          )
        : Text(
            icon.emoji!,
            style: const TextStyle(fontSize: 25),
          );
  }
}
