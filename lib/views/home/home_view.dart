import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/view_models/home_view_model.dart';
import 'package:about_myself/utils/responsive_helper.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/views/widgets/responsive_app_bar.dart';
import 'package:about_myself/views/widgets/responsive_container.dart';
import 'package:about_myself/views/widgets/responsive_footer.dart';
import 'package:about_myself/views/widgets/section_title.dart';
import 'package:about_myself/views/widgets/loading_widgets.dart';

/// Responsive Home View
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Load home data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().initializeHome();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final isMobile = context.responsive.isMobile;
    final isTablet = context.responsive.isTablet;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: ResponsiveAppBar(
        isScrolled: _isScrolled,
        onHomePressed: () {},
        onCaseStudiesPressed: () {
          Navigator.pushNamed(context, '/case-studies');
        },
        onTestimonialsPressed: () {
          Navigator.pushNamed(context, '/testimonials');
        },
        onWorksPressed: () {
          Navigator.pushNamed(context, '/recent-works');
        },
        onContactPressed: () {
          Navigator.pushNamed(context, '/get-in-touch');
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            _HeroSection(isMobile: isMobile, isTablet: isTablet),
            
            // Featured Works Section
            const SizedBox(height: AppSpacing.sectionPaddingDesktop),
            _FeaturedWorksSection(
              viewModel: viewModel,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            
            // Blog Preview Section
            const SizedBox(height: AppSpacing.sectionPaddingDesktop),
            _BlogPreviewSection(
              viewModel: viewModel,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            
            // CTA Section
            const SizedBox(height: AppSpacing.sectionPaddingDesktop),
            _CTASection(isMobile: isMobile, isTablet: isTablet),
            
            // Footer
            const SizedBox(height: AppSpacing.sectionPaddingDesktop),
            ResponsiveFooter(
              onHomePressed: () {},
              onGithubPressed: () {
                // TODO: Open GitHub link
              },
              onLinkedinPressed: () {
                // TODO: Open LinkedIn link
              },
              onTwitterPressed: () {
                // TODO: Open Twitter link
              },
              onEmailPressed: () {
                // TODO: Open email
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Hero section with intro and CTA
class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _HeroSection({
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? AppSpacing.horizontalPaddingMobile
            : isTablet
                ? AppSpacing.horizontalPaddingTablet
                : AppSpacing.horizontalPaddingDesktop,
        vertical: AppSpacing.sectionPaddingDesktop,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildHeroContent(context),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildHeroContent(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.xl4),
                Expanded(
                  flex: 1,
                  child: _buildHeroAvatar(),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildHeroContent(BuildContext context) {
    return [
      Text(
        'Hi, I\'m Azamat',
        style: AppTextStyles.displayMedium.copyWith(
          color: AppColors.white,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
      ),
      const SizedBox(height: AppSpacing.md),
      Text(
        'Full Stack Developer & Designer',
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.primary,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
      ),
      const SizedBox(height: AppSpacing.lg),
      Text(
        'I craft beautiful, responsive web experiences with Flutter, Firebase, and modern design principles. Let\'s build something amazing together.',
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.onSurfaceVariant,
          height: 1.6,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
      ),
      const SizedBox(height: AppSpacing.xl),
      SizedBox(
        width: isMobile ? double.infinity : null,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/get-in-touch');
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Get In Touch'),
        ),
      ),
    ];
  }

  Widget _buildHeroAvatar() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Container(
            width: 295,
            height: 295,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkBackground,
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 120,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Featured recent works section
class _FeaturedWorksSection extends StatelessWidget {
  final HomeViewModel viewModel;
  final bool isMobile;
  final bool isTablet;

  const _FeaturedWorksSection({
    required this.viewModel,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        children: [
          SectionTitle(
            title: 'Featured Works',
            subtitle: 'Selected projects that showcase my skills',
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
                childAspectRatio: 1.2,
              ),
              itemCount: 3,
              itemBuilder: (context, index) => LoadingSkeleton(
                width: double.infinity,
                height: 250,
              ),
            )
          else if (viewModel.recentWorks.isEmpty)
            EmptyStateWidget(
              title: 'No Works Yet',
              subtitle: 'Check back soon for exciting projects',
              icon: Icons.work_outline,
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
    );
  }
}

/// Work card widget
class _WorkCard extends StatelessWidget {
  final dynamic work;

  const _WorkCard({required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.outline.withOpacity(0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to work detail
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(
                    Icons.image,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  work.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  work.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Blog preview section
class _BlogPreviewSection extends StatelessWidget {
  final HomeViewModel viewModel;
  final bool isMobile;
  final bool isTablet;

  const _BlogPreviewSection({
    required this.viewModel,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        children: [
          SectionTitle(
            title: 'Latest Articles',
            subtitle: 'Insights and tips from my experience',
            showDivider: true,
          ),
          const SizedBox(height: AppSpacing.sectionPaddingDesktop),
          if (viewModel.isLoading)
            Column(
              children: List.generate(2, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: LoadingSkeleton(
                    width: double.infinity,
                    height: 150,
                  ),
                );
              }),
            )
          else if (viewModel.blogs.isEmpty)
            EmptyStateWidget(
              title: 'No Blogs Yet',
              subtitle: 'Writing is in progress',
              icon: Icons.article_outlined,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.blogs.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.lg),
              itemBuilder: (context, index) {
                final blog = viewModel.blogs[index];
                return _BlogCard(blog: blog);
              },
            ),
        ],
      ),
    );
  }
}

/// Blog card widget
class _BlogCard extends StatelessWidget {
  final dynamic blog;

  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.outline.withOpacity(0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to blog detail
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  blog.content,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Read more →',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// CTA section
class _CTASection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _CTASection({
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkCard,
      child: ResponsiveContainer(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? AppSpacing.horizontalPaddingMobile
              : isTablet
                  ? AppSpacing.horizontalPaddingTablet
                  : AppSpacing.horizontalPaddingDesktop,
          vertical: AppSpacing.sectionPaddingDesktop,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ready to work together?',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Have an exciting project or opportunity? Let\'s connect and create something amazing',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/get-in-touch');
              },
              icon: const Icon(Icons.email),
              label: const Text('Get In Touch'),
            ),
          ],
        ),
      ),
    );
  }
}
