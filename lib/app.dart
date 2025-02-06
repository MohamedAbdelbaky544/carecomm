import 'package:carecomm/core/presentation/themes/app_theme.dart';
import 'package:carecomm/core/presentation/utils/generated/translation/translations.dart';
import 'package:carecomm/core/presentation/utils/routing/route_info.dart';
import 'package:carecomm/core/presentation/utils/routing/router.dart';
import 'package:carecomm/product/presentations/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp.router(
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      theme: Theme.of(context).appTheme(Brightness.light).getThemeData(context),
      themeMode: ThemeMode.light,
      routerConfig: _goRouterConfig,
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _goRouterConfig = GoRouter(
  initialLocation: ProductPage.path,
  navigatorKey: _rootNavigatorKey,
  routes: Routes.I.routes.map(
    (route) {
      if (route.routeType == RouteType.shell) {
        return ShellRoute(
          builder: (context, state, child) =>
              route.builder(context, state, child),
          routes: (route.routes ?? [])
              .map(
                (subRoute) => GoRoute(
                    path: subRoute.path!,
                    name: subRoute.name ?? subRoute.path,
                    pageBuilder: (context, state) => NoTransitionPage(
                          child: subRoute.builder(context, state, null),
                        ),
                    routes: (subRoute.routes ?? [])
                        .map(
                          (childSubRoute) => GoRoute(
                            parentNavigatorKey: _rootNavigatorKey,
                            path: childSubRoute.path!,
                            name: childSubRoute.name ?? childSubRoute.path,
                            builder: (context, state) =>
                                childSubRoute.builder(context, state, null),
                          ),
                        )
                        .toList()),
              )
              .toList(),
        );
      }
      return GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: route.path!,
        name: route.name ?? route.path,
        builder: (context, state) => route.builder(context, state, null),
        routes: (route.routes ?? [])
            .map(
              (subRoute) => GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: subRoute.path!,
                name: subRoute.name ?? subRoute.path,
                builder: (context, state) =>
                    subRoute.builder(context, state, null),
              ),
            )
            .toList(),
      );
    },
  ).toList(),
);
