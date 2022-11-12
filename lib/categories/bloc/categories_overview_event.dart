part of 'categories_overview_bloc.dart';

abstract class CategoriesOverviewEvent extends Equatable {
  const CategoriesOverviewEvent();

  @override
  List<Object> get props => [];
}

class CategoriesOverviewDataRequested extends CategoriesOverviewEvent {}

class CategoriesOverviewDeleteRequested extends CategoriesOverviewEvent {
  const CategoriesOverviewDeleteRequested(this.id);
  final String id;
}
