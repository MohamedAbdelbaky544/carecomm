import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:carecomm/core/presentation/extension/tr.dart';
import 'package:carecomm/main/presentation/utils/bottom_item_model.dart';
import 'package:carecomm/main/presentation/widgets/bottom_navigation_item.dart';
import 'package:carecomm/product/presentations/pages/product_page.dart';
import 'package:carecomm/product/presentations/pages/product_wish_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  static String path = '/mainPage';
  const MainPage(this.child, {super.key});
  final Widget child;

  @override
  State<MainPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<MainPage> {
  List<BottomItemModel> _items = <BottomItemModel>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _items = [
        BottomItemModel(
          title: context.translation.home,
          route: ProductPage.path,
          iconUnSelected: Icon(
            Icons.home,
            color: context.appColor.grey,
          ),
          iconSelected: Icon(
            Icons.home,
            color: context.primaryColor,
          ),
        ),
        BottomItemModel(
          title: context.translation.wishList,
          route: ProductWishListPage.path,
          iconUnSelected: Icon(
            CupertinoIcons.heart_fill,
            color: context.appColor.grey,
          ),
          iconSelected: Icon(
            CupertinoIcons.heart_fill,
            color: context.primaryColor,
          ),
        ),
      ];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 88),
              child: widget.child,
            ),
          ),
          _BottomNavigationBar(
            items: _items,
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.items,
  });
  final List<BottomItemModel> items;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Container(
      height: 88,
      width: screenSize.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: context.appColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: context.appColor.blackColor.withOpacity(0.12),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: context.appColor.greyColor.withOpacity(0.7),
            offset: const Offset(0, 1),
            blurRadius: 60,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((e) {
          return BottomNavigationItem(
            iconSelected: e.iconSelected!,
            iconUnSelected: e.iconUnSelected!,
            route: e.route!,
            selected: GoRouterState.of(context).fullPath == e.route,
            text: e.title!,
          );
        }).toList(),
      ),
    );
  }
}
