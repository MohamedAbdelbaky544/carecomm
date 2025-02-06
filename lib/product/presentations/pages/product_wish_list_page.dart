import 'package:cached_network_image/cached_network_image.dart';
import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/presentations/cubits/get_all_product_in_wish_list_cubit.dart';
import 'package:carecomm/product/presentations/pages/product_details_page.dart';
import 'package:carecomm/product/presentations/pages/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductWishListPage extends StatefulWidget {
  static const String path = '/Product_WishList_Page';
  const ProductWishListPage({super.key});

  @override
  State<ProductWishListPage> createState() => _ProductWishListPageState();
}

class _ProductWishListPageState extends State<ProductWishListPage> {
  final GetAllProductInWishListCubit _cubit =
      getIt<GetAllProductInWishListCubit>();

  LayoutType layoutType = LayoutType.grid;

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
        bloc: _cubit,
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(
                    height: 16,
                  ),
                  state.item?.length == 0
                      ? Expanded(
                          child: Center(
                            child: Text(
                              context.translation.thereIsNoProductInWishList,
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.sizeOf(context).width < 768
                                      ? 2
                                      : MediaQuery.sizeOf(context).width < 1024
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
                                      'id': state.item![index].id.toString()
                                    }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: context.appColor.whiteColor,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            child: state.item?[index].image !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: state
                                                        .item![index].image!,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Tooltip(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  message: state
                                                          .item?[index].title ??
                                                      '',
                                                  child: Text(
                                                    state.item?[index].title ??
                                                        '',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Tooltip(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  message:
                                                      '${context.translation.price} : ${state.item?[index].price}',
                                                  child: Text(
                                                    '${context.translation.price} : ${state.item?[index].price}',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .textTheme.titleLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
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
        },
      ),
    );
  }
}
