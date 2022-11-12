import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances_app/categories/bloc/add_category_bloc.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';
import 'package:personal_finances_app/provider/api_provider.dart';
import 'package:personal_finances_app/widgets/custom_navigation_bar.dart';
import 'package:personal_finances_app/widgets/input_text_field.dart';

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
      child: CategoryCreateView(
        isEdit: category != null,
        category: category,
      ),
    );
  }
}

class CategoryCreateView extends StatefulWidget {
  const CategoryCreateView({super.key, required this.isEdit, this.category});
  final bool isEdit;
  final Category? category;

  @override
  State<CategoryCreateView> createState() => _CategoryCreateViewState();
}

class _CategoryCreateViewState extends State<CategoryCreateView> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  int initalIndex = 0;

  int getInitalIndex(Category? category) {
    if (category == null || category.icon == null) return 0;

    if (category.icon!.iconType == IconType.emoji) return 0;
    if (category.icon!.iconType == IconType.externalResource) return 1;
    return 0;
  }

  @override
  void initState() {
    initalIndex = getInitalIndex(widget.category);
    final iconValue =
        context.read<AddCategoryBloc>().state.category.icon?.emoji;
    if (iconValue != null) {
      _controller.text = iconValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCategoryBloc, AddCategoryState>(
      listener: (context, state) {
        if (state.status == AddCategoryStatus.successCreated ||
            state.status == AddCategoryStatus.successEdited) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.status == AddCategoryStatus.successCreated
                    ? 'Categoría creada.'
                    : 'Categoría editada.',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop(true);
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: DefaultTabController(
        initialIndex: initalIndex,
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
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _NameTextField(),
                    LabelWidget(
                      label: 'Emoji',
                      child: TextFormField(
                        controller: _controller,
                        readOnly: true,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 22),
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                emojiShowing = !emojiShowing;
                              });
                            },
                            child: const Icon(
                              Icons.emoji_emotions_outlined,
                              size: 22,
                            ),
                          ),
                          hintText: 'Emoji',
                          hintStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !emojiShowing,
                      child: SizedBox(
                        height: 350,
                        child: emoji.EmojiPicker(
                          textEditingController: _controller,
                          onEmojiSelected: (category, emoji) {
                            _controller
                              ..clear()
                              ..text = emoji.emoji;
                            context
                                .read<AddCategoryBloc>()
                                .add(AddCategoryEmojiChanged(emoji.emoji));
                          },
                          config: emoji.Config(
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                            bgColor: const Color(0xFFF2F2F2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _NameTextField(),
                    PreviewIconImage(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: ButtonNavBar(
            labelText: widget.isEdit ? 'Editar' : 'Crear',
            onPressed: () => context.read<AddCategoryBloc>().add(
                  const AddCategorySubmitted(),
                ),
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'Nombre',
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: context.read<AddCategoryBloc>().state.category.name,
        decoration: const InputDecoration(hintText: 'Nombre'),
        onChanged: (value) =>
            context.read<AddCategoryBloc>().add(AddCategoryNameChanged(value)),
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
            LabelWidget(
              label: 'Url',
              child: TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(hintText: 'Url'),
                initialValue: url,
                onChanged: (value) => context
                    .read<AddCategoryBloc>()
                    .add(AddCategoryUrlChanged(value)),
              ),
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
