import 'package:flutter/material.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';
import 'package:about_myself/theme/app_colors.dart';

/// Responsive container that centers content and limits max width
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;
  final Color? backgroundColor;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth = AppSpacing.maxContentWidth,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: screenWidth < 600
          ? AppSpacing.horizontalPaddingMobile
          : screenWidth < 1200
              ? AppSpacing.horizontalPaddingTablet
              : AppSpacing.horizontalPaddingDesktop,
    );

    return Container(
      color: backgroundColor,
      padding: padding ?? defaultPadding,
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
        ),
        child: child,
      ),
    );
  }
}
