import 'package:flutter/material.dart';

class AppColors {
  // Converted from CSS variables
  static const Color primaryGreen = Color(0xFF81F18E);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color darkerGreen = Color(0xFF1B5E20);
  static const Color pastelGreen = Color(0xFFE8FCE9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF9FFF9);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF555555);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryGreen,
    scaffoldBackgroundColor: AppColors.offWhite,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.textDark,
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.darkerGreen,
        backgroundColor: AppColors.primaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textLight),
    ),
    cardTheme: CardThemeData( 
      color: AppColors.pastelGreen,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    // ... Add more component themes
  );
}