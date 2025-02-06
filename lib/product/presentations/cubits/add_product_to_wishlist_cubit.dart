import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/use_cases/add_product_to_wishlist_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class AddProductToWishlistCubit extends Cubit<BaseState<Unit>> {
  final AddProductToWishlistUseCase useCase;
  AddProductToWishlistCubit(this.useCase) : super(const BaseState());

  void addNewProduct({required Product task}) async {
    emit(state.setInProgressState());
    final result = await useCase.call(task);
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (success) => emit(state.setSuccessState(success)),
    );
  }
}
