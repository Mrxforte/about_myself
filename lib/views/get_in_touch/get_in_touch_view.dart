import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/view_models/get_in_touch_view_model.dart';
import 'package:about_myself/views/widgets/responsive_app_bar.dart';
import 'package:about_myself/views/widgets/responsive_container.dart';
import 'package:about_myself/views/widgets/responsive_footer.dart';
import 'package:about_myself/views/widgets/section_title.dart';
import 'package:about_myself/theme/app_colors.dart';
import 'package:about_myself/utils/app_spacing.dart';
import 'package:about_myself/utils/app_text_styles.dart';

class GetInTouchView extends StatefulWidget {
  const GetInTouchView({super.key});

  @override
  State<GetInTouchView> createState() => _GetInTouchViewState();
}

class _GetInTouchViewState extends State<GetInTouchView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GetInTouchViewModel>();
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
                    title: 'Get In Touch',
                    subtitle: 'Let\'s collaborate and create something amazing',
                    showDivider: true,
                  ),
                  const SizedBox(height: AppSpacing.sectionPaddingDesktop),
                  // Success message
                  if (viewModel.isSuccess)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                        border: Border.all(color: AppColors.success),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 48,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            viewModel.successMessage,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.success,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ElevatedButton(
                            onPressed: () {
                              viewModel.clearMessages();
                              viewModel.resetForm();
                            },
                            child: const Text('Send Another Message'),
                          ),
                        ],
                      ),
                    )
                  else
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'Your name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onChanged: viewModel.updateName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Email field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'your.email@example.com',
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: viewModel.updateEmail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Phone field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Phone (Optional)',
                              hintText: '+1 (555) 123-4567',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: viewModel.updatePhone,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Subject field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              hintText: 'What is this about?',
                              prefixIcon: Icon(Icons.subject),
                            ),
                            onChanged: viewModel.updateSubject,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Message field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Message',
                              hintText: 'Tell me about your project or inquiry...',
                              prefixIcon: Icon(Icons.message),
                            ),
                            minLines: 5,
                            maxLines: 10,
                            onChanged: viewModel.updateMessage,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a message';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          // Error message
                          if (viewModel.hasError)
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                                border: Border.all(color: AppColors.error),
                              ),
                              child: Text(
                                viewModel.errorMessage,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          if (viewModel.hasError) const SizedBox(height: AppSpacing.lg),
                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        viewModel.submitForm();
                                      }
                                    },
                              child: viewModel.isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Send Message'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sectionPaddingDesktop),
            ResponsiveFooter(),
          ],
        ),
      ),
    );
  }
}
