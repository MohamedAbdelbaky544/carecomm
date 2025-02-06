import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/use_cases/get_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductCubit extends Cubit<BaseState<List<Product>>> {
  final GetProductUseCase _useCase;

  GetProductCubit(this._useCase) : super(const BaseState());

  void getProduct({
    String? category,
  }) async {
    emit(state.setInProgressState());
    final result = category != null
        ? await _useCase.call('/category/$category')
        : await _useCase.call(category);

    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (product) => emit(state.setSuccessState(product)),
    );
  }
}
