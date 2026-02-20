import 'package:flutter/material.dart';

/// Responsive breakpoints for different screen sizes
class ResponsiveBreakpoints {
  // Breakpoint values in logical pixels
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1200.0;

  // Screen size categories
  static const double mobileMax = 600.0;
  static const double tabletMin = 600.0;
  static const double tabletMax = 1200.0;
  static const double desktopMin = 1200.0;
}

/// Helper class for responsive design
class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);

  /// Get screen width
  double get screenWidth => MediaQuery.of(context).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(context).size.height;

  /// Check if screen is mobile
  bool get isMobile => screenWidth < ResponsiveBreakpoints.mobileBreakpoint;

  /// Check if screen is tablet
  bool get isTablet =>
      screenWidth >= ResponsiveBreakpoints.tabletBreakpoint &&
      screenWidth < ResponsiveBreakpoints.desktopMin;

  /// Check if screen is desktop
  bool get isDesktop => screenWidth >= ResponsiveBreakpoints.desktopMin;

  /// Check if screen is small
  bool get isSmall =>
      screenWidth < (ResponsiveBreakpoints.mobileBreakpoint - 100);

  /// Get device orientation
  Orientation get orientation => MediaQuery.of(context).orientation;

  /// Check if portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Screen aspect ratio
  double get aspectRatio => screenWidth / screenHeight;

  /// Get responsive value based on screen size
  T getResponsiveValue<T>({
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (isMobile) {
      return mobile;
    } else if (isTablet) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get responsive value with simple mobile/desktop
  T getValue<T>({
    required T mobile,
    required T desktop,
  }) {
    return isMobile ? mobile : desktop;
  }

  /// Get responsive padding
  EdgeInsets getResponsivePadding({
    required double mobileHorizontal,
    required double mobileVertical,
    required double tabletHorizontal,
    required double tabletVertical,
    required double desktopHorizontal,
    required double desktopVertical,
  }) {
    if (isMobile) {
      return EdgeInsets.symmetric(
        horizontal: mobileHorizontal,
        vertical: mobileVertical,
      );
    } else if (isTablet) {
      return EdgeInsets.symmetric(
        horizontal: tabletHorizontal,
        vertical: tabletVertical,
      );
    } else {
      return EdgeInsets.symmetric(
        horizontal: desktopHorizontal,
        vertical: desktopVertical,
      );
    }
  }

  /// Get responsive text scale factor
  double get textScaleFactor => MediaQuery.of(context).textScaleFactor;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding =>
      MediaQuery.of(context).padding + MediaQuery.of(context).viewInsets;

  /// Safe area top (status bar height)
  double get safeAreaTop => MediaQuery.of(context).padding.top;

  /// Safe area bottom (notch height)
  double get safeAreaBottom => MediaQuery.of(context).padding.bottom;
}

/// Extension on BuildContext for easy access to responsive helper
extension ResponsiveContext on BuildContext {
  ResponsiveHelper get responsive => ResponsiveHelper(this);
}
