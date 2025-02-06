import 'package:carecomm/core/presentation/utils/routing/route_info.dart';
import 'package:carecomm/main/presentation/pages/main_page.dart';
import 'package:carecomm/product/presentations/pages/product_details_page.dart';
import 'package:carecomm/product/presentations/pages/product_page.dart';
import 'package:carecomm/product/presentations/pages/product_wish_list_page.dart';

class Routes {
  Routes._();

  static Routes I = Routes._();

  final routes = [
    RouteInfo(
      routeType: RouteType.shell,
      builder: (context, state, child) => MainPage(child!),
      routes: [
        RouteInfo(
            path: ProductPage.path,
            builder: (context, state, _) => const ProductPage(),
            routes: [
              RouteInfo(
                path: ProductDetailsPage.path,
                builder: (context, state, _) => ProductDetailsPage(
                  id: state.uri.queryParameters['id']!,
                ),
              ),
            ]),
        RouteInfo(
          path: ProductWishListPage.path,
          builder: (context, state, _) => const ProductWishListPage(),
        ),
      ],
    ),
  ];
}
