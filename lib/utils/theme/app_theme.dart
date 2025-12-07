import 'package:flutter/material.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),

    scaffoldBackgroundColor: AppColor.primary,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.gray200),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.red),
      ),
      fillColor: AppColor.gray200,
      filled: true,
    ),
  );
}
