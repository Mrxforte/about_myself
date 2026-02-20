import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/view_models/case_studies_view_model.dart';
import 'package:about_myself/views/widgets/responsive_app_bar.dart';
import 'package:about_myself/views/widgets/responsive_container.dart';
import 'package:about_myself/views/widgets/responsive_footer.dart';
import 'package:about_myself/views/widgets/section_title.dart';
import 'package:about_myself/views/widgets/loading_widgets.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';

class CaseStudiesView extends StatefulWidget {
  const CaseStudiesView({super.key});

  @override
  State<CaseStudiesView> createState() => _CaseStudiesViewState();
}

class _CaseStudiesViewState extends State<CaseStudiesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CaseStudiesViewModel>().loadCaseStudies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CaseStudiesViewModel>();
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
                    title: 'Case Studies',
                    subtitle: 'In-depth looks at my projects and solutions',
                    showDivider: true,
                  ),
                  const SizedBox(height: AppSpacing.sectionPaddingDesktop),
                  if (viewModel.isLoading)
                    LoadingSkeleton(
                      width: double.infinity,
                      height: 300,
                    )
                  else if (viewModel.caseStudies.isEmpty)
                    EmptyStateWidget(
                      title: 'No Case Studies Available',
                      subtitle: 'Check back soon',
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.caseStudies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
                      itemBuilder: (context, index) {
                        final caseStudy = viewModel.caseStudies[index];
                        return _CaseStudyCard(caseStudy: caseStudy);
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

class _CaseStudyCard extends StatelessWidget {
  final dynamic caseStudy;

  const _CaseStudyCard({required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              caseStudy.title,
              style: AppTextStyles.headlineSmall.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              caseStudy.description,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              children: (caseStudy.technologies as List).map<Widget>((tech) {
                return Chip(
                  label: Text(tech, style: const TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  labelStyle: const TextStyle(color: Colors.white),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
