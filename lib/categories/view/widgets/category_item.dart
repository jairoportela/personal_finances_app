import 'package:flutter/material.dart';
import 'package:personal_finances_app/categories/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.item});

  final Category item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.icon.iconType == IconType.externalResource
          ? CircleAvatar(
              child: Image.network(item.icon.externalUrl!.url),
            )
          : Text(item.icon.emoji!),
      title: Text(item.name),
      onTap: () async {},
    );
  }
}
