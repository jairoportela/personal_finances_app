import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances_app/categories/bloc/categories_overview_bloc.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/view/category_page_create.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.item});

  final Category item;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.item.icon != null
          ? _LeadingIcon(
              icon: widget.item.icon!,
            )
          : null,
      title: Text(widget.item.name),
      onTap: () async {
        final value = await Navigator.of(context)
            .pushNamed(CategoryCreatePage.routeName, arguments: widget.item);
        if (!mounted) return;
        if (value != null && value == true) {
          context
              .read<CategoriesOverviewBloc>()
              .add(CategoriesOverviewDataRequested());
        }
      },
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
