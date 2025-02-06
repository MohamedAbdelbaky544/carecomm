import 'package:flutter/material.dart';

class BottomItemModel {
  final String? title;
  final String? route;
  final Icon? iconSelected;
  final Icon? iconUnSelected;

  final BottomItemStyle style;

  const BottomItemModel({
    this.title,
    this.route,
    this.iconSelected,
    this.iconUnSelected,
    this.style = BottomItemStyle.normal,
  });
}

enum BottomItemStyle { normal, overlay }
