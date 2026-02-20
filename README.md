# About Myself - Flutter Portfolio App

A modern, responsive Flutter portfolio application showcasing projects, case studies, testimonials, and recent work. Built with Firebase backend and optimized for mobile, web, and desktop platforms.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- 🎨 **Modern UI/UX** - Responsive design that works seamlessly across mobile, web, and desktop
- 🔐 **Authentication** - Firebase Authentication with email/password and Google Sign-In support
- 📱 **Multi-Platform** - Runs on iOS, Android, Web, Windows, macOS, and Linux
- 🌙 **Dark Theme** - Built-in dark theme for all screens
- 📊 **Portfolio Showcase** - Display case studies, recent works, testimonials, and blog posts
- 💬 **Contact Form** - Collect messages from visitors
- 🔌 **Firebase Integration** - Cloud Firestore for data management
- 📸 **Image Management** - Firebase Storage for images and media
- ⚡ **Offline Support** - **NEW:** Full offline functionality with fallback dummy data
- 🚀 **State Management** - Provider pattern for efficient state management

## 🆕 Firebase Fallback System

The app now includes a **robust offline-first architecture** that automatically displays dummy data when Firebase is unavailable. This ensures the application remains fully functional even without internet connectivity.

### How It Works

```
Firebase Available? 
  ├─ Yes → Fetch from Firebase
  └─ No  → Display Fallback Data (Demo Content)
```

### Offline Features

| Feature | Behavior |
|---------|----------|
| **View Portfolio** | Shows demo case studies, testimonials, and recent works |
| **View Profile** | Displays fallback user profile data |
| **Submit Contact Form** | Generates local ID, can be synced when online |
| **Authentication** | Gracefully handles unavailable auth with informative messages |
| **Data Loading** | Returns empty/fallback data instead of crashing |

### What's Included in Fallback Data

- **Case Studies** - 2 demo projects with full details
- **Testimonials** - 3 sample testimonials from fictitious clients
- **Recent Works** - 3 recent projects across different categories
- **User Profile** - Complete demo portfolio user information
- **Blog Posts** - 2 sample blog articles (when implemented)

### Implementation Details

#### FirebaseService (lib/services/firebase/firebase_service.dart)
- Tracks Firebase availability status
- Sets `_isAvailable` flag on successful initialization
- Provides `isAvailable` getter for checking status

#### FirestoreService (lib/services/firebase/firestore_service.dart)
- Checks `FirebaseService.isAvailable` before operations
- Returns empty collections/documents gracefully
- Falls back to `Stream.value([])` for stream operations
- Silently fails for write operations without throwing exceptions

#### AuthService (lib/services/firebase/auth_service.dart)
- Verifies Firebase availability in all auth operations
- Provides user-friendly error messages
- Returns null/empty streams when Firebase is unavailable

#### Repository Pattern
All repositories implement fallback behavior:
- **UserRepository** - Returns demo user profile
- **CaseStudyRepository** - Uses hardcoded case study data
- **TestimonialRepository** - Displays sample testimonials
- **RecentWorkRepository** - Shows demo projects
- **BlogRepository** - Provides fallback blog content
- **ContactRepository** - Supports offline form submissions

## 📁 Project Structure

```
lib/
├── main.dart                           # App entry point
├── config/
│   └── firebase_constants.dart        # Firebase configuration constants
├── models/                             # Data models
│   ├── user_model.dart
│   ├── case_study_model.dart
│   ├── testimonial_model.dart
│   ├── recent_work_model.dart
│   ├── blog_model.dart
│   └── contact_model.dart
├── repositories/                       # Data access layer with fallback support
│   ├── user_repository.dart
│   ├── case_study_repository.dart
│   ├── testimonial_repository.dart
│   ├── recent_work_repository.dart
│   ├── blog_repository.dart
│   └── contact_repository.dart
├── services/
│   ├── firebase/                       # Firebase services
│   │   ├── firebase_service.dart      # Initialization & availability tracking
│   │   ├── firestore_service.dart     # Firestore with offline fallback
│   │   ├── auth_service.dart          # Authentication with fallback
│   │   ├── storage_service.dart       # Firebase Storage
│   │   └── firebase_options.dart
│   └── ...
├── theme/                              # App theming
│   ├── app_colors.dart
│   └── app_theme.dart
├── utils/                              # Utility functions
│   ├── responsive_helper.dart
│   ├── app_spacing.dart
│   ├── app_text_styles.dart
│   └── ...
├── view_models/                        # Business logic (MVVM pattern)
│   ├── auth_view_model.dart
│   ├── home_view_model.dart
│   ├── case_studies_view_model.dart
│   ├── testimonials_view_model.dart
│   ├── recent_works_view_model.dart
│   └── get_in_touch_view_model.dart
└── views/                              # UI Screens
    ├── home/
    │   └── home_view.dart
    ├── case_studies/
    │   └── case_studies_view.dart
    ├── testimonials/
    │   └── testimonials_view.dart
    ├── recent_works/
    │   └── recent_works_view.dart
    ├── get_in_touch/
    │   └── get_in_touch_view.dart
    └── widgets/                        # Reusable UI components
        ├── responsive_app_bar.dart
        ├── responsive_container.dart
        ├── responsive_footer.dart
        └── ...
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Firebase Project Setup
- Android Studio / Xcode / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mrxforte/about_myself.git
   cd about_myself
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   
   The app requires Firebase configuration files. Place them in the appropriate directories:
   - **Android**: `android/app/google-services.json`
   - **iOS**: `ios/Runner/GoogleService-Info.plist`
   - **Web**: Configured in `web/index.html`

4. **Run the app**
   ```bash
   # iOS/Android
   flutter run
   
   # Web
   flutter run -d chrome
   
   # Desktop (Windows/macOS/Linux)
   flutter run -d windows  # or -d macos, -d linux
   ```

## 🔧 Configuration

### Firebase Setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable required services:
   - Authentication (Email/Password, Google Sign-In)
   - Cloud Firestore
   - Storage
3. Download and configure authentication credentials for your platforms
4. Update `lib/services/firebase/firebase_options.dart` with your project details

### Firestore Collections

The app expects the following Firestore collections:

```
firestore/
├── users/                    # User profiles
├── caseStudies/             # Portfolio case studies
├── testimonials/            # Client testimonials
├── recentWorks/             # Recent projects
├── blogPosts/               # Blog articles
└── contactSubmissions/      # Contact form submissions
```

## 🏗️ Architecture

### MVVM Pattern

The app uses the Model-View-ViewModel (MVVM) architecture:

```
View Layer (UI Screens)
    ↓ (notifies)
ViewModel (Business Logic & State)
    ↓ (fetches data)
Repository Layer (Data Access with Fallback)
    ↓ (uses)
Services (Firebase, Firestore, Auth)
    ↓
Firebase Backend + Local Fallback Data
```

### State Management

- **Provider Package** - For state management across the app
- **ChangeNotifier** - For reactive data updates
- **Streams** - For real-time data from Firestore

## 📱 Responsive Design

The app automatically adapts to different screen sizes:

```
Mobile (< 600dp)
    ↓
Tablet (600dp - 1200dp)
    ↓
Desktop (> 1200dp)
```

Helper utilities in `lib/utils/responsive_helper.dart` provide size detection and responsive layouts.

## 🌐 Deployment

### Web
```bash
flutter build web --release
# Deploy the build/web directory to your hosting service
```

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
# Open ios/Runner.xcworkspace in Xcode to sign and deploy
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Development

### Adding New Features

1. Create a model in `lib/models/`
2. Create a repository in `lib/repositories/` with fallback data
3. Create a ViewModel in `lib/view_models/`
4. Create a View/Screen in `lib/views/`
5. Add navigation in `lib/main.dart`

### Best Practices

- ✅ Always use the repository pattern for data access
- ✅ Check `FirebaseService.isAvailable` before Firebase operations
- ✅ Return fallback data instead of throwing exceptions
- ✅ Use `debugPrint()` for debugging (removed in release builds)
- ✅ Implement responsive layouts with `ResponsiveHelper`
- ✅ Use `ChangeNotifier` for state management

## 🆘 Troubleshooting

### Firebase Initialization Fails
The app will automatically display fallback data. Check:
- Firebase credentials are properly configured
- Internet connection is available
- Firebase project is active and not rate-limited

### Build Issues
```bash
# Clean build
flutter clean
flutter pub get
flutter pub upgrade

# Rebuild
flutter run
```

### Web Platform Issues
```bash
# Clear Chrome cache
flutter clean
flutter run -d chrome
```

## 📚 Dependencies

Key packages used:

```yaml
flutter:
  sdk: flutter

# State Management
provider: ^6.0.0

# Firebase
firebase_core: ^2.0.0
firebase_auth: ^4.0.0
cloud_firestore: ^4.0.0
firebase_storage: ^11.0.0

# Authentication
google_sign_in: ^6.0.0

# UI/UX
get_it: ^7.0.0

# Utilities
connectivity_plus: ^5.0.0
sqflite: ^2.0.0
path_provider: ^2.0.0
```

See [pubspec.yaml](pubspec.yaml) for complete dependency list.

## 🎯 Upcoming Features

- [ ] Blog posts with rich text editor
- [ ] Portfolio statistics and analytics
- [ ] Email notifications for contact form
- [ ] Dark/Light theme toggle
- [ ] Localization (Multi-language support)
- [ ] Push notifications
- [ ] Comments on blog posts
- [ ] Social media sharing

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 👨‍💼 Author

**Azamat**
- GitHub: [@Mrxforte](https://github.com/Mrxforte)
- Portfolio: [about_myself](https://github.com/Mrxforte/about_myself)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Provider package for state management
- All contributors and testers

## 📮 Support

For issues, questions, or suggestions:
- Open an issue on [GitHub Issues](https://github.com/Mrxforte/about_myself/issues)
- Check existing documentation in `QUICK_START.md` and `IMPLEMENTATION_GUIDE.md`

---

**Made with ❤️ using Flutter**
