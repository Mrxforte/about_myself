import 'package:flutter/material.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_text_styles.dart';

/// App theme configuration following Material 3 design
class AppTheme {
  /// Dark theme data
  static ThemeData darkTheme = ThemeData(
    // Color scheme
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      scrim: AppColors.scrim,
      inverseSurface: AppColors.white,
      onInverseSurface: AppColors.black,
      inversePrimary: AppColors.primaryLight,
      brightness: Brightness.dark,
    ),

    // Scaffolding
    scaffoldBackgroundColor: AppColors.darkBackground,
    canvasColor: AppColors.darkCard,

    // Appbar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.white,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: AppTextStyles.button,
      ),
    ),

    // Text fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: AppTextStyles.labelLarge.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Typography
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.white,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.white,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppColors.white,
      ),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppColors.white,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.white,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.white,
      ),
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.white,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.white,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.white,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.white,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.white,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppColors.onSurfaceVariant,
      ),
    ),

    // Other components
    dividerColor: AppColors.outline,
    dividerTheme: const DividerThemeData(
      color: AppColors.outline,
      space: 16,
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.surfaceVariant;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 0.5);
        }
        return AppColors.surfaceVariant.withValues(alpha: 0.3);
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.surfaceVariant;
      }),
      side: const BorderSide(color: AppColors.outline),
    ),

    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.surfaceVariant;
      }),
    ),

    // Icon theme
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),

    // Tooltips
    tooltipTheme: const TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      textStyle: TextStyle(
        color: AppColors.white,
        fontSize: 14,
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Bottom sheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkCard,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Progress indicators
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.surfaceVariant,
      circularTrackColor: AppColors.surfaceVariant,
    ),

    // Extensions
    extensions: const [
      // Additional theme customizations can be added here
    ],
  );

  /// Light theme data
  static ThemeData lightTheme = ThemeData(
    // Color scheme
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      scrim: AppColors.scrim,
      inverseSurface: AppColors.black,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.primaryLight,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.white,
    canvasColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.black,
      ),
    ),
  );
}
