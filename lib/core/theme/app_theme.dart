// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors (from your HSL)
  static const Color primaryLight = Color(0xFF22C55E); // hsl(143 76% 41%)
  static const Color backgroundLight = Color(0xFFFAFAFA); // hsl(0 0% 98%)
  static const Color foregroundLight = Color(0xFF1A1A1A); // hsl(240 10% 10%)
  static const Color cardLight = Color(0xFFFFFFFF); // hsl(0 0% 100%)
  static const Color mutedLight = Color(0xFFF5F5F5); // hsl(240 5% 96%)
  static const Color borderLight = Color(0xFFE5E5E7); // hsl(240 6% 90%)
  static const Color destructiveLight = Color(0xFFDC2626); // hsl(0 84% 60%)
  static const Color mutedForegroundLight =
      Color(0xFF737373); // hsl(240 4% 46%)
  static const Color secondaryLight = Color(0xFFF0F9F2); // hsl(143 20% 95%)
  static const Color secondaryForegroundLight =
      Color(0xFF15803D); // hsl(143 76% 35%)

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF22C55E); // Same primary
  static const Color backgroundDark = Color(0xFF1A1A1A); // hsl(240 10% 10%)
  static const Color foregroundDark = Color(0xFFFAFAFA); // hsl(0 0% 98%)
  static const Color cardDark = Color(0xFF202020); // hsl(240 10% 12%)
  static const Color mutedDark = Color(0xFF2A2A2A); // hsl(240 10% 18%)
  static const Color borderDark = Color(0xFF333333); // hsl(240 10% 20%)
  static const Color destructiveDark = Color(0xFFB91C1C); // hsl(0 62% 50%)
  static const Color mutedForegroundDark = Color(0xFFA3A3A3); // hsl(240 5% 65%)
  static const Color secondaryDark = Color(0xFF2A2A2A); // hsl(240 10% 18%)
}

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.light,

        // Color Scheme - Material 3
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryLight,
          onPrimary: Colors.white,
          secondary: AppColors.secondaryLight,
          onSecondary: AppColors.secondaryForegroundLight,
          background: AppColors.backgroundLight,
          onBackground: AppColors.foregroundLight,
          surface: AppColors.cardLight,
          onSurface: AppColors.foregroundLight,
          error: AppColors.destructiveLight,
          onError: Colors.white,
          outline: AppColors.borderLight,
          outlineVariant: AppColors.borderLight.withOpacity(0.5),
        ),

        // Scaffold
        scaffoldBackgroundColor: AppColors.backgroundLight,

        // App Bar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundLight,
          foregroundColor: AppColors.foregroundLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundLight,
          ),
          iconTheme: IconThemeData(color: AppColors.foregroundLight),
        ),

        // Card Theme - FIXED: Using CardThemeData() constructor
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.borderLight, width: 1),
          ),
          margin: EdgeInsets.zero,
          surfaceTintColor: Colors.transparent,
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cardLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.destructiveLight),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: TextStyle(color: AppColors.mutedForegroundLight),
          labelStyle: TextStyle(color: AppColors.foregroundLight),
        ),

        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            side: BorderSide(color: AppColors.borderLight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),

        // Text Theme
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.foregroundLight,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundLight,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundLight,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundLight,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.foregroundLight,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.mutedForegroundLight,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.mutedForegroundLight,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),

        // Icon Theme
        iconTheme: IconThemeData(
          color: AppColors.foregroundLight,
        ),

        // Divider Theme
        dividerTheme: DividerThemeData(
          color: AppColors.borderLight,
          thickness: 1,
          space: 0,
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.mutedLight,
          selectedColor: AppColors.primaryLight,
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.foregroundLight,
          ),
          secondaryLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,

        // Color Scheme - Material 3
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryDark,
          onPrimary: Colors.white,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.foregroundDark,
          background: AppColors.backgroundDark,
          onBackground: AppColors.foregroundDark,
          surface: AppColors.cardDark,
          onSurface: AppColors.foregroundDark,
          error: AppColors.destructiveDark,
          onError: Colors.white,
          outline: AppColors.borderDark,
          outlineVariant: AppColors.borderDark.withOpacity(0.5),
        ),

        // Scaffold
        scaffoldBackgroundColor: AppColors.backgroundDark,

        // App Bar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: AppColors.foregroundDark,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundDark,
          ),
          iconTheme: IconThemeData(color: AppColors.foregroundDark),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.borderDark, width: 1),
          ),
          margin: EdgeInsets.zero,
          surfaceTintColor: Colors.transparent,
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cardDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.destructiveDark),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: TextStyle(color: AppColors.mutedForegroundDark),
          labelStyle: TextStyle(color: AppColors.foregroundDark),
        ),

        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Text Theme for Dark Mode
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.foregroundDark,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundDark,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundDark,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.foregroundDark,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.mutedForegroundDark,
          ),
        ),

        // Divider Theme
        dividerTheme: DividerThemeData(
          color: AppColors.borderDark,
          thickness: 1,
          space: 0,
        ),
      );
}
