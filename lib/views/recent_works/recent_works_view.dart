import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/view_models/recent_works_view_model.dart';
import 'package:about_myself/views/widgets/responsive_app_bar.dart';
import 'package:about_myself/views/widgets/responsive_container.dart';
import 'package:about_myself/views/widgets/responsive_footer.dart';
import 'package:about_myself/views/widgets/section_title.dart';
import 'package:about_myself/views/widgets/loading_widgets.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';

class RecentWorksView extends StatefulWidget {
  const RecentWorksView({super.key});

  @override
  State<RecentWorksView> createState() => _RecentWorksViewState();
}

class _RecentWorksViewState extends State<RecentWorksView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecentWorksViewModel>().loadRecentWorks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecentWorksViewModel>();
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 1200;

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
                    title: 'Recent Works',
                    subtitle: 'Latest projects and creations',
                    showDivider: true,
                  ),
                  const SizedBox(height: AppSpacing.sectionPaddingDesktop),
                  if (viewModel.isLoading)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
                        crossAxisSpacing: AppSpacing.lg,
                        mainAxisSpacing: AppSpacing.lg,
                      ),
                      itemCount: 6,
                      itemBuilder: (_, __) => LoadingSkeleton(height: 250),
                    )
                  else if (viewModel.recentWorks.isEmpty)
                    EmptyStateWidget(
                      title: 'No Works Available',
                      subtitle: 'Check back soon for exciting projects',
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
                        crossAxisSpacing: AppSpacing.lg,
                        mainAxisSpacing: AppSpacing.lg,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: viewModel.recentWorks.length,
                      itemBuilder: (context, index) {
                        final work = viewModel.recentWorks[index];
                        return _WorkCard(work: work);
                      },
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

class _WorkCard extends StatelessWidget {
  final dynamic work;

  const _WorkCard({required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSpacing.radiusLg),
                topRight: Radius.circular(AppSpacing.radiusLg),
              ),
            ),
            child: Icon(Icons.image, color: AppColors.primary),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  work.title,
                  style: AppTextStyles.titleSmall.copyWith(color: AppColors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  work.description,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
