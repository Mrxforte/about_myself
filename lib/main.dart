import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about_myself/services/firebase/firebase_service.dart';
import 'package:about_myself/theme/app_theme.dart';
import 'package:about_myself/view_models/auth_view_model.dart';
import 'package:about_myself/view_models/home_view_model.dart';
import 'package:about_myself/view_models/case_studies_view_model.dart';
import 'package:about_myself/view_models/testimonials_view_model.dart';
import 'package:about_myself/view_models/recent_works_view_model.dart';
import 'package:about_myself/view_models/get_in_touch_view_model.dart';
import 'package:about_myself/views/home/home_view.dart';
import 'package:about_myself/views/case_studies/case_studies_view.dart';
import 'package:about_myself/views/testimonials/testimonials_view.dart';
import 'package:about_myself/views/recent_works/recent_works_view.dart';
import 'package:about_myself/views/get_in_touch/get_in_touch_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await FirebaseService.initialize();
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth ViewModel - for authentication state
        ChangeNotifierProvider(create: (_) => AuthViewModel()..initializeAuth()),
        
        // Feature ViewModels
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CaseStudiesViewModel()),
        ChangeNotifierProvider(create: (_) => TestimonialsViewModel()),
        ChangeNotifierProvider(create: (_) => RecentWorksViewModel()),
        ChangeNotifierProvider(create: (_) => GetInTouchViewModel()),
      ],
      child: MaterialApp(
        title: 'About Myself',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        
        // Route configuration for navigation
        routes: {
          '/': (context) => const HomeView(),
          '/case-studies': (context) => const CaseStudiesView(),
          '/testimonials': (context) => const TestimonialsView(),
          '/recent-works': (context) => const RecentWorksView(),
          '/get-in-touch': (context) => const GetInTouchView(),
        },
        
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (settings.name) {
                case '/':
                  return const HomeView();
                case '/case-studies':
                  return const CaseStudiesView();
                case '/testimonials':
                  return const TestimonialsView();
                case '/recent-works':
                  return const RecentWorksView();
                case '/get-in-touch':
                  return const GetInTouchView();
                default:
                  return const HomeView();
              }
            },
          );
        },
      ),
    );
  }
}
