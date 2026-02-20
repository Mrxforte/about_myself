import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Firebase initialization service
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  static bool _isAvailable = false;

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  /// Initialize Firebase app
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _isAvailable = true;
    } catch (e) {
      _isAvailable = false;
      rethrow;
    }
  }

  /// Check if Firebase is already initialized
  static bool get isInitialized => Firebase.apps.isNotEmpty;

  /// Check if Firebase is available and initialized
  static bool get isAvailable => _isAvailable && Firebase.apps.isNotEmpty;
}
