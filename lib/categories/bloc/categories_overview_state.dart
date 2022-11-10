part of 'categories_overview_bloc.dart';

abstract class CategoriesOverviewState extends Equatable {
  const CategoriesOverviewState();

  @override
  List<Object> get props => [];
}

class CategoriesOverviewEmpty extends CategoriesOverviewState {}

class CategoriesOverviewLoading extends CategoriesOverviewState {}

class CategoriesOverviewSuccess extends CategoriesOverviewState {
  const CategoriesOverviewSuccess(this.items);

  final List<Category> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'CategoriesOverviewSuccess { items: ${items.length} }';
}

class CategoriesOverviewError extends CategoriesOverviewState {
  const CategoriesOverviewError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
