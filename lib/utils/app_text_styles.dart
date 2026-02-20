import 'package:flutter/material.dart';

/// App text styles following Material 3 design
class AppTextStyles {
  // Display styles (large headings)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.22,
  );

  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.33,
  );

  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 1.27,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // Custom styles
  static const TextStyle button = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.39,
  );

  /// Get responsive heading style
  static TextStyle getResponsiveHeading({
    required double height,
  }) {
    if (height < 600) {
      return headlineSmall;
    } else if (height < 1200) {
      return headlineMedium;
    } else {
      return headlineLarge;
    }
  }

  /// Get responsive display style
  static TextStyle getResponsiveDisplay({
    required double height,
  }) {
    if (height < 600) {
      return displaySmall;
    } else if (height < 1200) {
      return displayMedium;
    } else {
      return displayLarge;
    }
  }
}
