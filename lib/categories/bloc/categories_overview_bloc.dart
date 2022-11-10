import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/models/category_error.dart';
import 'package:personal_finances_app/categories/repository/category_repository.dart';

part 'categories_overview_event.dart';
part 'categories_overview_state.dart';

class CategoriesOverviewBloc
    extends Bloc<CategoriesOverviewEvent, CategoriesOverviewState> {
  CategoriesOverviewBloc({required this.categoryRepository})
      : super(CategoriesOverviewEmpty()) {
    on<CategoriesOverviewDataRequested>(_onDataRequested);
  }

  Future<void> _onDataRequested(
    CategoriesOverviewDataRequested event,
    Emitter<CategoriesOverviewState> emit,
  ) async {
    emit(CategoriesOverviewLoading());

    try {
      final results = await categoryRepository.getCategories();
      emit(CategoriesOverviewSuccess(results.items));
    } catch (error) {
      emit(
        error is CategoriesError
            ? CategoriesOverviewError(error.message)
            : const CategoriesOverviewError('something went wrong'),
      );
    }
  }

  final CategoryRepository categoryRepository;
}
