import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances_app/categories/bloc/add_category_bloc.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';
import 'package:personal_finances_app/provider/api_provider.dart';

class CategoryCreatePage extends StatelessWidget {
  const CategoryCreatePage({
    super.key,
    this.category,
  });
  static const routeName = '/create-page';
  final Category? category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryBloc(
        categoryRepository: CategoryRepository(ApiProvider()),
        category: category,
      ),
      child: const CategoryCreateView(),
    );
  }
}

class CategoryCreateView extends StatelessWidget {
  const CategoryCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.emoji_emotions), text: 'Emoji'),
              Tab(
                icon: Icon(Icons.image),
                text: 'Image',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Nombre'),
                    onChanged: (value) => context
                        .read<AddCategoryBloc>()
                        .add(AddCategoryNameChanged(value)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Emoji'),
                    initialValue: context
                        .read<AddCategoryBloc>()
                        .state
                        .category
                        .icon
                        ?.emoji,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Nombre'),
                    initialValue:
                        context.read<AddCategoryBloc>().state.category.name,
                    onChanged: (value) => context
                        .read<AddCategoryBloc>()
                        .add(AddCategoryNameChanged(value)),
                  ),
                  const PreviewIconImage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            ElevatedButton(onPressed: () {}, child: const Text('Crear')),
      ),
    );
  }
}

class PreviewIconImage extends StatelessWidget {
  const PreviewIconImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCategoryBloc, AddCategoryState, String?>(
      selector: (state) {
        return state.category.icon?.externalUrl?.url;
      },
      builder: (context, url) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Url'),
              initialValue: url,
              onChanged: (value) => context
                  .read<AddCategoryBloc>()
                  .add(AddCategoryUrlChanged(value)),
            ),
            const SizedBox(height: 20),
            const Text('Preview'),
            const SizedBox(height: 20),
            if (url != null)
              Image.network(
                url,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('No se puede mostrar contenido'),
              )
          ],
        );
      },
    );
  }
}
