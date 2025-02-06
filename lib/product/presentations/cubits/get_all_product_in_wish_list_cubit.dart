import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/use_cases/get_all_product_in_wish_list_use_case.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@lazySingleton
class GetAllProductInWishListCubit extends Cubit<BaseState<List<Product>?>> {
  final GetAllProductInWishListUseCase useCase;
  GetAllProductInWishListCubit(this.useCase) : super(const BaseState());

  void getProduct() async {
    emit(state.setInProgressState());
    final result = useCase.call();
    emit(state.setSuccessState(result));
  }
}
