import 'package:cached_network_image/cached_network_image.dart';
import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/core/presentation/widgets/error_view.dart';
import 'package:carecomm/core/presentation/widgets/loader.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/presentations/cubits/add_product_to_wishlist_cubit.dart';
import 'package:carecomm/product/presentations/cubits/delete_product_from_wish_list_cubit.dart';
import 'package:carecomm/product/presentations/cubits/get_all_product_in_wish_list_cubit.dart';
import 'package:carecomm/product/presentations/cubits/get_product_by_id_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String path = 'product_details_page';
  const ProductDetailsPage({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final GetProductByIdCubit _cubit = getIt<GetProductByIdCubit>();
  final DeleteProductFromWishListCubit deleteProductFromWishListCubit =
      getIt<DeleteProductFromWishListCubit>();
  final GetAllProductInWishListCubit getAllProductInWishListCubit =
      getIt<GetAllProductInWishListCubit>();
  final AddProductToWishlistCubit addProductToWishlistCubit =
      getIt<AddProductToWishlistCubit>();

  List<Product>? wishList = [];

  bool CheckItemInWishList() {
    bool outPut = false;
    if (wishList != null) {
      for (var product in wishList!) {
        if (product.id.toString() == widget.id) {
          outPut = true;

          break;
        }
      }
    }

    return outPut;
  }

  @override
  void initState() {
    _cubit.getProductById(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translation.productDetails,
          style: context.textTheme.titleLarge,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetProductByIdCubit, BaseState<Product>>(
            bloc: _cubit,
            listener: (context, state) {
              if (state.isSuccess) {
                getAllProductInWishListCubit.getProduct();
              }
            },
          ),
          BlocListener<GetAllProductInWishListCubit, BaseState<List<Product>?>>(
            bloc: getAllProductInWishListCubit,
            listener: (context, state) {
              if (state.isSuccess) {
                wishList = state.item;

                setState(() {});
              }
            },
          ),
          BlocListener<AddProductToWishlistCubit, BaseState>(
            bloc: addProductToWishlistCubit,
            listener: (context, state) {
              if (state.isSuccess) {
                getAllProductInWishListCubit.getProduct();
              }
            },
          ),
          BlocListener<DeleteProductFromWishListCubit, BaseState<int>>(
            bloc: deleteProductFromWishListCubit,
            listener: (context, state) {
              if (state.isSuccess) {
                getAllProductInWishListCubit.getProduct();
              }
            },
          ),
        ],
        child: BlocBuilder<GetProductByIdCubit, BaseState<Product>>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.isInProgress) {
              return const Center(child: Loader());
            } else if (state.isFailure) {
              return const Center(child: ErrorView());
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 250,
                          width: double.maxFinite,
                          child: state.item?.image != null
                              ? CachedNetworkImage(
                                  imageUrl: state.item!.image!,
                                  fit: BoxFit.fitHeight,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 32,
                                  ),
                                )
                              : const Icon(
                                  Icons.image,
                                ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: InkWell(
                            onTap: () {
                              if (CheckItemInWishList()) {
                                deleteProductFromWishListCubit.deleteProduct(
                                    index: state.item!.id);
                              } else {
                                addProductToWishlistCubit.addNewProduct(
                                    product: state.item!);
                              }
                            },
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              color: CheckItemInWishList()
                                  ? context.primaryColor
                                  : context.appColor.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            state.item?.title ?? '',
                            style: context.textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '${context.translation.price} : ',
                                    style: context.textTheme.titleLarge,
                                    children: [
                                      TextSpan(
                                        text: state.item?.price.toString(),
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            state.item?.description ?? '',
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '${context.translation.category} : ',
                                    style: context.textTheme.titleLarge,
                                    children: [
                                      TextSpan(
                                        text: state.item?.category,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
