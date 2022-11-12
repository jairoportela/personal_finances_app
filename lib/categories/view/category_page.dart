import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances_app/categories/bloc/categories_overview_bloc.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';
import 'package:personal_finances_app/categories/view/category_page_create.dart';
import 'package:personal_finances_app/categories/view/widgets/category_item.dart';
import 'package:personal_finances_app/l10n/l10n.dart';
import 'package:personal_finances_app/provider/api_provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository(ApiProvider());
    return BlocProvider(
      create: (_) =>
          CategoriesOverviewBloc(categoryRepository: categoryRepository)
            ..add(CategoriesOverviewDataRequested()),
      child: const CategoriesView(),
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
      floatingActionButton: const CreateCategoryButton(),
    );
  }
}

class CreateCategoryButton extends StatefulWidget {
  const CreateCategoryButton({
    super.key,
  });

  @override
  State<CreateCategoryButton> createState() => _CreateCategoryButtonState();
}

class _CreateCategoryButtonState extends State<CreateCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final value =
            await Navigator.of(context).pushNamed(CategoryCreatePage.routeName);
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

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<CategoriesOverviewBloc>()
            .add(CategoriesOverviewDataRequested());
      },
      child: BlocBuilder<CategoriesOverviewBloc, CategoriesOverviewState>(
        builder: (context, state) {
          if (state is CategoriesOverviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoriesOverviewError) {
            return Center(child: Text(state.error));
          }
          if (state is CategoriesOverviewSuccess) {
            return state.items.isEmpty
                ? const Text('No Results')
                : _CategoriesResult(items: state.items);
          }
          return const Center(child: Text('Empty'));
        },
      ),
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
