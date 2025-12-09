import 'package:flutter/material.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),

    scaffoldBackgroundColor: AppColor.background,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.background,
    ),
    inputDecorationTheme: InputDecorationTheme(
      
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.black),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.red),
      ),
      fillColor: AppColor.primary,
      filled: true,
    ),
  );
}
