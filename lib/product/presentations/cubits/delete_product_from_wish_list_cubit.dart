import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/use_cases/delete_product_from_wish_list_use_case.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@lazySingleton
class DeleteProductFromWishListCubit extends Cubit<BaseState<int>> {
  final DeleteProductFromWishListUseCase useCase;
  DeleteProductFromWishListCubit(this.useCase) : super(const BaseState());

  void deleteProduct({required int index}) async {
    emit(state.setInProgressState());
    useCase.call(index: index);
    emit(state.setSuccessState(index));
  }
}
