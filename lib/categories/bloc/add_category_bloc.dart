import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  AddCategoryBloc({
    required this.categoryRepository,
    Category? category,
  })  : isEdit = category != null,
        super(AddCategoryState(category: category ?? Category.empty)) {
    on<AddCategoryNameChanged>(_onNameChange);
    on<AddCategoryEmojiChanged>(_onEmojiChange);
    on<AddCategoryUrlChanged>(_onUrlChanged);
    on<AddCategorySubmitted>(_onSubmitted);
  }

  final CategoryRepository categoryRepository;
  final bool isEdit;

  void _onNameChange(
    AddCategoryNameChanged event,
    Emitter<AddCategoryState> emit,
  ) {
    emit(state.copyWith(category: state.category.copyWith(name: event.name)));
  }

  void _onEmojiChange(
    AddCategoryEmojiChanged event,
    Emitter<AddCategoryState> emit,
  ) {
    emit(
      state.copyWith(
        category: state.category.copyWith(
          iconFunction: () => IconItem(
            iconType: IconType.emoji,
            emoji: event.emoji,
          ),
        ),
      ),
    );
  }

  void _onUrlChanged(
    AddCategoryUrlChanged event,
    Emitter<AddCategoryState> emit,
  ) {
    emit(
      state.copyWith(
        category: state.category.copyWith(
          iconFunction: () => IconItem(
            iconType: IconType.externalResource,
            externalUrl: ExternalUrl(event.url),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    AddCategorySubmitted event,
    Emitter<AddCategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AddCategoryStatus.loading));
      if (isEdit) {
        await categoryRepository.editCategory(state.category);
        return emit(state.copyWith(status: AddCategoryStatus.successEdited));
      }
      if (!isEdit) {
        await categoryRepository.createCategory(state.category);
        return emit(state.copyWith(status: AddCategoryStatus.successEdited));
      }
    } catch (error) {
      emit(state.copyWith(status: AddCategoryStatus.error));
    }
  }
}
