import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = _buildDarkTheme();
  static final ThemeData lightTheme = _buildLightTheme();

  static ThemeData _buildDarkTheme() {
    final base = ThemeData.dark();
    final textTheme = _buildTextTheme(base.textTheme);

    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.actionSecondary,
        surface: AppColors.surface,
        background: AppColors.background,
      ),
      textTheme: textTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.actionSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: const CardTheme(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 4.0),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.surface,
        thickness: 1,
      ),
    );
  }

  static ThemeData _buildLightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      textTheme: _buildTextTheme(base.textTheme),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return GoogleFonts.interTextTheme(base);
  }
}
