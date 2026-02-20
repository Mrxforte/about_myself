import 'package:flutter/material.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';
import 'package:about_myself/theme/app_colors.dart';

/// Responsive footer widget
class ResponsiveFooter extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onGithubPressed;
  final VoidCallback? onLinkedinPressed;
  final VoidCallback? onTwitterPressed;
  final VoidCallback? onEmailPressed;

  const ResponsiveFooter({
    super.key,
    this.onHomePressed,
    this.onGithubPressed,
    this.onLinkedinPressed,
    this.onTwitterPressed,
    this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 1200;

    return Container(
      width: double.infinity,
      color: AppColors.darkSurface,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? AppSpacing.horizontalPaddingMobile
            : isTablet
                ? AppSpacing.horizontalPaddingTablet
                : AppSpacing.horizontalPaddingDesktop,
        vertical: AppSpacing.sectionPaddingDesktop,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Social links
              Wrap(
                spacing: AppSpacing.md,
                children: [
                  _FooterIconButton(
                    icon: Icons.public,
                    tooltip: 'Home',
                    onPressed: onHomePressed,
                  ),
                  _FooterIconButton(
                    icon: Icons.code,
                    tooltip: 'GitHub',
                    onPressed: onGithubPressed,
                  ),
                  _FooterIconButton(
                    icon: Icons.business,
                    tooltip: 'LinkedIn',
                    onPressed: onLinkedinPressed,
                  ),
                  _FooterIconButton(
                    icon: Icons.share,
                    tooltip: 'Twitter',
                    onPressed: onTwitterPressed,
                  ),
                  _FooterIconButton(
                    icon: Icons.email,
                    tooltip: 'Email',
                    onPressed: onEmailPressed,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // Divider
              Container(
                height: 1,
                color: AppColors.outline.withOpacity(0.3),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Copyright
              Text(
                '© 2024 All rights reserved. Built with Flutter',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  const _FooterIconButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: AppColors.primary,
        hoverColor: AppColors.primary.withOpacity(0.1),
      ),
    );
  }
}
