import 'package:flutter/material.dart';

/// App color scheme following Material 3 design
class AppColors {
  // Primary colors - Main brand color
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color primary = Color(0xFF5A4FC6);
  static const Color primaryDark = Color(0xFF4A3FA5);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary colors - Supporting brand color
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondary = Color(0xFF05B9A0);
  static const Color secondaryDark = Color(0xFF00897B);
  static const Color secondaryContainer = Color(0xFFB1ECE4);
  static const Color onSecondaryContainer = Color(0xFF00231E);

  // Tertiary colors - Additional accent color
  static const Color tertiaryLight = Color(0xFFFF0000);
  static const Color tertiary = Color(0xFFF44336);
  static const Color tertiaryDark = Color(0xFFC62828);
  static const Color tertiaryContainer = Color(0xFFFFDAD6);
  static const Color onTertiaryContainer = Color(0xFF410002);

  // Neutral colors - Dark theme background
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color surface = Color(0xFF000000);
  static const Color surfaceVariant = Color(0xFF49454E);
  static const Color surfaceTint = Color(0xFF6200EE);

  // Text colors
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onSurfaceVariant = Color(0xFFCAC7D0);

  // Error colors
  static const Color error = Color(0xFFB3261E);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF410E0B);

  // Outline colors
  static const Color outline = Color(0xFF938F99);
  static const Color outlineVariant = Color(0xFF49454E);

  // Scrim (semi-transparent overlay)
  static const Color scrim = Color(0xFF000000);

  // Brightness and transparency
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Custom colors for dark theme
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF1A1F3A);
  static const Color darkCard = Color(0xFF242A45);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  static const Color disabled = Color(0xFF9E9E9E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFF5A4FC6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFFF44336)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Opacity values
  static const double opacityHigh = 0.87;
  static const double opacityMedium = 0.60;
  static const double opacityLow = 0.38;
  static const double opacityDisabled = 0.12;

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get tinted color
  static Color tint(Color color, double tintValue) {
    return Color.lerp(color, white, tintValue) ?? color;
  }

  /// Get shaded color
  static Color shade(Color color, double shadeValue) {
    return Color.lerp(color, black, shadeValue) ?? color;
  }
}
