import 'package:flutter/material.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';

/// Loading skeleton widget
class LoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const LoadingSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: borderRadius,
      ),
      child: ShimmerEffect(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.onSurfaceVariant.withOpacity(0.1),
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading effect
class ShimmerEffect extends StatefulWidget {
  final Widget child;

  const ShimmerEffect({
    super.key,
    required this.child,
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.white.withOpacity(0),
                AppColors.white.withOpacity(0.5),
                AppColors.white.withOpacity(0),
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Error widget with retry button
class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }
}

/// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}
