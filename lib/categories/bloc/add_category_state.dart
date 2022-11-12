part of 'add_category_bloc.dart';

enum AddCategoryStatus {
  initial,
  loading,
  successCreated,
  successEdited,
  error
}

class AddCategoryState extends Equatable {
  const AddCategoryState({
    this.category = Category.empty,
    this.status = AddCategoryStatus.initial,
  });

  final AddCategoryStatus status;
  final Category category;

  AddCategoryState copyWith({
    Category? category,
    AddCategoryStatus? status,
  }) {
    return AddCategoryState(
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [category, status];
}
