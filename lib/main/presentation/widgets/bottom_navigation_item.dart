import 'package:carecomm/core/presentation/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    required this.text,
    required this.route,
    required this.iconSelected,
    required this.iconUnSelected,
    required this.selected,
  });
  final bool selected;
  final Icon iconSelected;
  final Icon iconUnSelected;
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: context.appColor.primaryColor.tint),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 24,
              height: 24,
              child: iconSelected,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.primaryColor,
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () => context.go(route),
        child: Container(
          padding: const EdgeInsets.all(2),
          width: 24,
          height: 24,
          child: iconUnSelected,
        ),
      );
    }
  }
}
