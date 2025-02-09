import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:carecomm/core/presentation/widgets/error_view.dart';
import 'package:carecomm/core/presentation/widgets/loader.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/presentations/cubits/add_product_to_wishlist_cubit.dart';
import 'package:carecomm/product/presentations/cubits/app_cubit.dart';
import 'package:carecomm/product/presentations/cubits/delete_product_from_wish_list_cubit.dart';
import 'package:carecomm/product/presentations/cubits/get_all_product_in_wish_list_cubit.dart';
import 'package:carecomm/product/presentations/cubits/get_product_cubit.dart';
import 'package:carecomm/product/presentations/pages/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatefulWidget {
  static const String path = '/product_page';
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GetProductCubit _cubit = getIt<GetProductCubit>();
  final GetAllProductInWishListCubit getAllProductInWishListCubit =
      getIt<GetAllProductInWishListCubit>();

  final DeleteProductFromWishListCubit deleteProductFromWishListCubit =
      getIt<DeleteProductFromWishListCubit>();
  final AddProductToWishlistCubit addProductToWishlistCubit =
      getIt<AddProductToWishlistCubit>();

  final AppCubit appCubit = getIt<AppCubit>();
  LayoutType layoutType = LayoutType.grid;

  List<Product>? wishList = [];
  @override
  void initState() {
    _cubit.getProduct();

    super.initState();
  }

  bool checkProductInWishList({required int id, List<Product>? wishList}) {
    bool outPut = false;
    if (wishList != null) {
      for (var product in wishList) {
        if (product.id == id) {
          outPut = true;

          break;
        }
      }
    }

    return outPut;
  }

  @override
  Widget build(BuildContext context) {
    getAllProductInWishListCubit.getProduct();
    return BlocBuilder<AppCubit, BaseState>(
      bloc: appCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: MediaQuery.sizeOf(context).width,
            leading: Row(
              children: [
                Assets.images.logo.image(),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'CareComm',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  onPressed: () {
                    appCubit.changeTheme();
                  },
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppCubit.theme == ThemeMode.dark
                          ? Row(
                              children: [
                                Icon(
                                  Icons.sunny,
                                  color: context.primaryColor,
                                ),
                              ],
                            )
                          : Icon(
                              Icons.bedtime_sharp,
                              color: context.primaryColor,
                            ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Theme',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<GetAllProductInWishListCubit,
                  BaseState<List<Product>?>>(
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
              BlocListener<GetProductCubit, BaseState<List<Product>>>(
                bloc: _cubit,
                listener: (context, state) {
                  if (state.isSuccess) {
                    getAllProductInWishListCubit.getProduct();
                  }
                },
              ),
            ],
            child: BlocBuilder<GetProductCubit, BaseState<List<Product>>>(
              bloc: _cubit,
              builder: (context, state) {
                if (state.isInProgress) {
                  return const Center(child: Loader());
                } else if (state.isFailure) {
                  return const Center(child: ErrorView());
                } else {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.translation.products,
                                style:
                                    context.textTheme.headlineLarge?.copyWith(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 48,
                                width: 48,
                                child: Card(
                                  color: context.appColor.cardBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (layoutType == LayoutType.list) {
                                        layoutType = LayoutType.grid;
                                      } else {
                                        layoutType = LayoutType.list;
                                      }

                                      setState(() {});
                                    },
                                    child: Icon(
                                      switch (layoutType) {
                                        LayoutType.list => Icons.list,
                                        LayoutType.grid =>
                                          CupertinoIcons.square_grid_2x2,
                                      },
                                      color: context.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          layoutType == LayoutType.grid
                              ? Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.item?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => context.pushNamed(
                                              ProductDetailsPage.path,
                                              queryParameters: {
                                                'id': state.item![index].id
                                                    .toString()
                                              }),
                                          child: Container(
                                            height: 200,
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: context
                                                  .appColor.cardBackgroundColor,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  height: 200,
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: 200,
                                                        child: state
                                                                    .item?[
                                                                        index]
                                                                    .image !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: state
                                                                    .item![
                                                                        index]
                                                                    .image!,
                                                                fit:
                                                                    BoxFit.fill,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(
                                                                  Icons.error,
                                                                  size: 32,
                                                                ),
                                                              )
                                                            : const Icon(
                                                                Icons.image,
                                                              ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (checkProductInWishList(
                                                                id: state
                                                                    .item![
                                                                        index]
                                                                    .id,
                                                                wishList:
                                                                    wishList)) {
                                                              deleteProductFromWishListCubit
                                                                  .deleteProduct(
                                                                      index: state
                                                                          .item![
                                                                              index]
                                                                          .id);
                                                              setState(() {});
                                                            } else {
                                                              addProductToWishlistCubit
                                                                  .addNewProduct(
                                                                      product: state
                                                                              .item![
                                                                          index]);
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .heart_fill,
                                                            color: checkProductInWishList(
                                                                    id: state
                                                                        .item![
                                                                            index]
                                                                        .id,
                                                                    wishList:
                                                                        wishList)
                                                                ? context
                                                                    .primaryColor
                                                                : context
                                                                    .appColor
                                                                    .grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Tooltip(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          message: state
                                                                  .item?[index]
                                                                  .title ??
                                                              '',
                                                          child: Text(
                                                            state.item?[index]
                                                                    .title ??
                                                                '',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Tooltip(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          message:
                                                              '${context.translation.price} : ${state.item?[index].price}',
                                                          child: Text(
                                                            '${context.translation.price} : ${state.item?[index].price}',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: context
                                                                .textTheme
                                                                .titleLarge,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                              : Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          MediaQuery.sizeOf(context).width < 768
                                              ? 2
                                              : MediaQuery.sizeOf(context)
                                                          .width <
                                                      1024
                                                  ? 3
                                                  : 4,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      mainAxisExtent: 250,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: state.item?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => context.pushNamed(
                                            ProductDetailsPage.path,
                                            queryParameters: {
                                              'id': state.item![index].id
                                                  .toString()
                                            }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: context
                                                .appColor.cardBackgroundColor,
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 100,
                                                    child: state.item?[index]
                                                                .image !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: state
                                                                .item![index]
                                                                .image!,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    const Icon(
                                                              Icons.error,
                                                              size: 32,
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons.image,
                                                          ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Tooltip(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          message: state
                                                                  .item?[index]
                                                                  .title ??
                                                              '',
                                                          child: Text(
                                                            state.item?[index]
                                                                    .title ??
                                                                '',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Tooltip(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          message:
                                                              '${context.translation.price} : ${state.item?[index].price}',
                                                          child: Text(
                                                            '${context.translation.price} : ${state.item?[index].price}',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: context
                                                                .textTheme
                                                                .titleLarge,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (checkProductInWishList(
                                                        id: state
                                                            .item![index].id,
                                                        wishList: wishList)) {
                                                      deleteProductFromWishListCubit
                                                          .deleteProduct(
                                                              index: state
                                                                  .item![index]
                                                                  .id);
                                                      setState(() {});
                                                    } else {
                                                      addProductToWishlistCubit
                                                          .addNewProduct(
                                                              product:
                                                                  state.item![
                                                                      index]);
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: Icon(
                                                    CupertinoIcons.heart_fill,
                                                    color:
                                                        checkProductInWishList(
                                                                id: state
                                                                    .item![
                                                                        index]
                                                                    .id,
                                                                wishList:
                                                                    wishList)
                                                            ? context
                                                                .primaryColor
                                                            : context
                                                                .appColor.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

enum LayoutType { list, grid }
