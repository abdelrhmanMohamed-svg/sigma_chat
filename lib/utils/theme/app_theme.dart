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
  );
}
