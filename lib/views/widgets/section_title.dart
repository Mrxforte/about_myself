import 'package:flutter/material.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';
import 'package:about_myself/theme/app_colors.dart';

/// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final bool showDivider;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.start,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.white,
          ),
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
        if (showDivider) ...[
          const SizedBox(height: AppSpacing.lg),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ],
    );
  }
}
