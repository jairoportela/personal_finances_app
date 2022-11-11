part of 'add_category_bloc.dart';

abstract class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object> get props => [];
}

class AddCategoryNameChanged extends AddCategoryEvent {
  const AddCategoryNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AddCategoryEmojiChanged extends AddCategoryEvent {
  const AddCategoryEmojiChanged(this.emoji);

  final String emoji;

  @override
  List<Object> get props => [emoji];
}

class AddCategoryUrlChanged extends AddCategoryEvent {
  const AddCategoryUrlChanged(this.url);

  final String url;

  @override
  List<Object> get props => [url];
}

class AddCategorySubmitted extends AddCategoryEvent {
  const AddCategorySubmitted();
}
