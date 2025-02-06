import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteInfo {
  final String? path;
  final Widget Function(
    BuildContext context,
    GoRouterState state,
    Widget? child,
  ) builder;
  final bool showInDrawer;
  final String? name;
  final String? iconPath;
  final Widget Function(
    BuildContext context,
    GoRouterState state,
    Widget? child,
  )? shellBuilder;

  final List<RouteInfo>? routes;
  final RouteType routeType;
  const RouteInfo({
    this.path,
    required this.builder,
    this.shellBuilder,
    this.showInDrawer = false,
    this.iconPath,
    this.name,
    this.routes,
    this.routeType = RouteType.normal,
  });
}

enum RouteType { normal, shell }
