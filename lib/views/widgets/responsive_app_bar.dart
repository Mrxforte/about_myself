import 'package:flutter/material.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';
import 'package:about_myself/theme/app_colors.dart';

/// Responsive app bar for web/mobile
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onCaseStudiesPressed;
  final VoidCallback? onTestimonialsPressed;
  final VoidCallback? onWorksPressed;
  final VoidCallback? onContactPressed;
  final bool isScrolled;

  const ResponsiveAppBar({
    super.key,
    this.onHomePressed,
    this.onCaseStudiesPressed,
    this.onTestimonialsPressed,
    this.onWorksPressed,
    this.onContactPressed,
    this.isScrolled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return AppBar(
      backgroundColor: isScrolled 
          ? AppColors.darkSurface.withOpacity(0.95)
          : AppColors.darkBackground,
      elevation: isScrolled ? 4 : 0,
      title: Text(
        'Portfolio',
        style: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.white,
        ),
      ),
      centerTitle: false,
      actions: isMobile
          ? [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Show mobile menu
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => _MobileMenu(
                      onHomePressed: onHomePressed,
                      onCaseStudiesPressed: onCaseStudiesPressed,
                      onTestimonialsPressed: onTestimonialsPressed,
                      onWorksPressed: onWorksPressed,
                      onContactPressed: onContactPressed,
                    ),
                  );
                },
              ),
            ]
          : [
              _NavButton(
                label: 'Home',
                onPressed: onHomePressed,
              ),
              _NavButton(
                label: 'Case Studies',
                onPressed: onCaseStudiesPressed,
              ),
              _NavButton(
                label: 'Testimonials',
                onPressed: onTestimonialsPressed,
              ),
              _NavButton(
                label: 'Recent Works',
                onPressed: onWorksPressed,
              ),
              _NavButton(
                label: 'Contact',
                onPressed: onContactPressed,
              ),
              const SizedBox(width: AppSpacing.md),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _NavButton({
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onCaseStudiesPressed;
  final VoidCallback? onTestimonialsPressed;
  final VoidCallback? onWorksPressed;
  final VoidCallback? onContactPressed;

  const _MobileMenu({
    this.onHomePressed,
    this.onCaseStudiesPressed,
    this.onTestimonialsPressed,
    this.onWorksPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkCard,
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onHomePressed?.call();
            },
          ),
          ListTile(
            title: const Text('Case Studies'),
            onTap: () {
              Navigator.pop(context);
              onCaseStudiesPressed?.call();
            },
          ),
          ListTile(
            title: const Text('Testimonials'),
            onTap: () {
              Navigator.pop(context);
              onTestimonialsPressed?.call();
            },
          ),
          ListTile(
            title: const Text('Recent Works'),
            onTap: () {
              Navigator.pop(context);
              onWorksPressed?.call();
            },
          ),
          ListTile(
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              onContactPressed?.call();
            },
          ),
        ],
      ),
    );
  }
}
