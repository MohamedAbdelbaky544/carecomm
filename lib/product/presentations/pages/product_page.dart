import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/core/presentation/widgets/error_view.dart';
import 'package:carecomm/core/presentation/widgets/loader.dart';
import 'package:carecomm/injection.dart';
import 'package:carecomm/product/domain/entities/product.dart';
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

  LayoutType layoutType = LayoutType.grid;

  @override
  void initState() {
    _cubit.getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GetProductCubit, BaseState<List<Product>>>(
        bloc: _cubit,
        listener: (context, state) {},
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
                          style: context.textTheme.headlineLarge?.copyWith(
                            color: context.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          width: 48,
                          child: Card(
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
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                                        child: state.item?[index].image != null
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    state.item![index].image!,
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
                                              margin: const EdgeInsets.all(8),
                                              message:
                                                  state.item?[index].title ??
                                                      '',
                                              child: Text(
                                                state.item?[index].title ?? '',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Tooltip(
                                              margin: const EdgeInsets.all(8),
                                              message:
                                                  '${context.translation.price} : ${state.item?[index].price}',
                                              child: Text(
                                                '${context.translation.price} : ${state.item?[index].price}',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: context
                                                    .textTheme.titleLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        CupertinoIcons.heart_fill,
                                        color: context.appColor.grey,
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
    );
  }
}

enum LayoutType { list, grid }
