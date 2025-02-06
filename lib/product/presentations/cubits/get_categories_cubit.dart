import 'package:carecomm/core/domain/use_cases/use_case.dart';
import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesCubit extends Cubit<BaseState<List<String>>> {
  final GetCategoriesUseCase _useCase;

  GetCategoriesCubit(this._useCase) : super(const BaseState());

  void getCategories() async {
    emit(state.setInProgressState());
    final result = await _useCase.call(const NoParams());
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (categories) => emit(state.setSuccessState(categories)),
    );
  }
}
