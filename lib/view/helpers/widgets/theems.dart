import 'package:flutter/material.dart';
import 'package:rheal/view/AppColors.dart';

class MyThemes {
  static const primary = AppColors.background;
  static final primaryColor = AppColors.shadow;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.shadow,
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: AppColors.text,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.text,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: AppColors.shadow,
  );
}
