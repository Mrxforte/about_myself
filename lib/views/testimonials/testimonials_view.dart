import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/view_models/testimonials_view_model.dart';
import 'package:about_myself/views/widgets/responsive_app_bar.dart';
import 'package:about_myself/views/widgets/responsive_container.dart';
import 'package:about_myself/views/widgets/responsive_footer.dart';
import 'package:about_myself/views/widgets/section_title.dart';
import 'package:about_myself/views/widgets/loading_widgets.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';

class TestimonialsView extends StatefulWidget {
  const TestimonialsView({super.key});

  @override
  State<TestimonialsView> createState() => _TestimonialsViewState();
}

class _TestimonialsViewState extends State<TestimonialsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestimonialsViewModel>().loadTestimonials();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TestimonialsViewModel>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: ResponsiveAppBar(
        onHomePressed: () => Navigator.pushNamed(context, '/'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResponsiveContainer(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.horizontalPaddingMobile : AppSpacing.horizontalPaddingDesktop,
                vertical: AppSpacing.sectionPaddingDesktop,
              ),
              child: Column(
                children: [
                  SectionTitle(
                    title: 'Testimonials',
                    subtitle: 'What clients and colleagues say about working with me',
                    showDivider: true,
                  ),
                  const SizedBox(height: AppSpacing.sectionPaddingDesktop),
                  if (viewModel.isLoading)
                    LoadingSkeleton(
                      width: double.infinity,
                      height: 250,
                    )
                  else if (viewModel.testimonials.isEmpty)
                    EmptyStateWidget(
                      title: 'No Testimonials Yet',
                      subtitle: 'Check back soon',
                    )
                  else
                    Column(
                      children: [
                        // Carousel testimonial
                        _TestimonialCarousel(
                          testimonial: viewModel.currentTestimonial!,
                          index: viewModel.currentCarouselIndex,
                          total: viewModel.testimonials.length,
                          onPrevious: viewModel.previousTestimonial,
                          onNext: viewModel.nextTestimonial,
                        ),
                        const SizedBox(height: AppSpacing.sectionPaddingDesktop),
                        // Grid of all testimonials
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 2,
                            crossAxisSpacing: AppSpacing.lg,
                            mainAxisSpacing: AppSpacing.lg,
                          ),
                          itemCount: viewModel.testimonials.length,
                          itemBuilder: (context, index) {
                            final testimonial = viewModel.testimonials[index];
                            return _TestimonialCard(testimonial: testimonial);
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            ResponsiveFooter(),
          ],
        ),
      ),
    );
  }
}

class _TestimonialCarousel extends StatelessWidget {
  final dynamic testimonial;
  final int index;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const _TestimonialCarousel({
    required this.testimonial,
    required this.index,
    required this.total,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return Icon(
                i < testimonial.rating.toInt() ? Icons.star : Icons.star_border,
                color: AppColors.primary,
              );
            }),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Quote
          Text(
            '"${testimonial.content}"',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          // Author
          Text(
            testimonial.authorName,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
          ),
          Text(
            testimonial.authorRole,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onPrevious,
              ),
              Text('$index / $total'),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: onNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final dynamic testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < testimonial.rating.toInt() ? Icons.star : Icons.star_border,
                color: AppColors.primary,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            testimonial.content,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            testimonial.authorName,
            style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
          ),
          Text(
            testimonial.authorRole,
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
