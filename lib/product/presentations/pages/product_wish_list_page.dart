import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/presentations/cubits/get_all_product_in_wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWishListPage extends StatefulWidget {
  static const String path = '/Product_WishList_Page';
  const ProductWishListPage({super.key});

  @override
  State<ProductWishListPage> createState() => _ProductWishListPageState();
}

class _ProductWishListPageState extends State<ProductWishListPage> {
  final GetAllProductInWishListCubit _cubit =
      getIt<GetAllProductInWishListCubit>();

  @override
  void initState() {
    _cubit.getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocConsumer<GetAllProductInWishListCubit, BaseState<List<Product>?>>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    context.translation.wishList,
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
