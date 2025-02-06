import 'package:flutter/material.dart';

enum StatusColor {
  orange,
  blue,
  green,
  red,
  orangeTint,
  blueTint,
  greenTint,
  redTint,
}

///create a [MaterialTextColor] class that has a related colors with enums [TextColor]
class MaterialTextColor extends ColorSwatch<TextColor> {
  const MaterialTextColor(super.primary, super.swatch);

  Color get dynamicGrey => this[TextColor.dynamicGrey]!;

  Color get grey => this[TextColor.grey]!;

  Color get darkGrey => this[TextColor.darkGrey]!;

  Color get white => this[TextColor.white]!;
  Color get lightGrey => this[TextColor.lightGrey]!;
}

enum TextColor {
  black,
  dynamicGrey,
  lightGrey,
  grey,
  darkGrey,
  white,
}

///create a [MaterialSecondaryColor] class that has a related colors with enums [PrimaryColor]
class MaterialPrimaryColor extends ColorSwatch<PrimaryColor> {
  const MaterialPrimaryColor(super.primary, super.swatch);

  Color get tint => this[PrimaryColor.tint] ?? _transparentColor;

  Color get _transparentColor => Colors.transparent;
}

enum PrimaryColor {
  tint,
}
