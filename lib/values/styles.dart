import 'package:flutter/material.dart';
import 'package:furniture_admin/values/colors.dart';

class Styles {
  Styles._();

  // Themes

  static final ColorScheme _colorSchemelight =
      const ColorScheme.light().copyWith(
    primary: mainColor,
  );

  static final ColorScheme _colorSchemedark = const ColorScheme.dark().copyWith(
    primary: greenish,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: _colorSchemelight,
    fontFamily: "Mazzard",
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: _colorSchemedark,
    fontFamily: "Mazzard",
  );
}
