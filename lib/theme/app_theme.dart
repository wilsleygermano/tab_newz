import 'package:flutter/material.dart';
import 'package:tab_newz/theme/app_colors.dart';

class AppTheme {
  ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.primaryLight,
    ),
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.primaryLight,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryLight,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
      ),
    ),
  );

  ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.primaryDark,
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryDark,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryLight,
      ),
    ),
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryLight,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryLight,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryLight,
      ),
    ),
  );
}
