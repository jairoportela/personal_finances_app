import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances_app/categories/bloc/categories_overview_bloc.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';
import 'package:personal_finances_app/categories/view/widgets/category_item.dart';
import 'package:personal_finances_app/l10n/l10n.dart';
import 'package:personal_finances_app/provider/api_provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository(ApiProvider());
    return BlocProvider(
      create: (_) =>
          CategoriesOverviewBloc(categoryRepository: categoryRepository),
      child: Container(),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.categoriesAppBarTitle)),
      body: _SearchBody(),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesOverviewBloc, CategoriesOverviewState>(
      builder: (context, state) {
        if (state is CategoriesOverviewLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CategoriesOverviewError) {
          return Text(state.error);
        }
        if (state is CategoriesOverviewSuccess) {
          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(child: _CategoriesResult(items: state.items));
        }
        return const Text('Empty');
      },
    );
  }
}

class _CategoriesResult extends StatelessWidget {
  const _CategoriesResult({required this.items});

  final List<Category> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryItem(item: items[index]);
      },
    );
  }
}
