import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductByIdCubit extends Cubit<BaseState<Product>> {
  final GetProductByIdUseCase _useCase;

  GetProductByIdCubit(this._useCase) : super(const BaseState());

  void getProductById({
    required String id,
  }) async {
    emit(state.setInProgressState());
    final result = await _useCase.call(id);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (product) => emit(state.setSuccessState(product)),
    );
  }
}
