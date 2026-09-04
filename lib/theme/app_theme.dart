import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Tajawal';

  static ThemeData get light {
    return ThemeData.light(useMaterial3: true).copyWith(
      textTheme: _textTheme,
      primaryTextTheme: _textTheme,
      typography: Typography.material2021(
        platform: defaultTargetPlatform,
        englishLike: Typography.englishLike2021.apply(fontFamily: fontFamily),
        dense: Typography.dense2021.apply(fontFamily: fontFamily),
        tall: Typography.tall2021.apply(fontFamily: fontFamily),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textTertiary,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size.fromHeight(52),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.4),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size.fromHeight(52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: const TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textOnPrimary,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceAlt,
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
      height: 1.3,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textTertiary,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
  );
}
