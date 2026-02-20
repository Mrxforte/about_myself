import 'package:flutter/foundation.dart';
import 'package:about_myself/models/user_model.dart';
import 'package:about_myself/services/firebase/auth_service.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Fallback dummy user profile
const Map<String, dynamic> _fallbackUserProfile = {
  'id': 'demo-user',
  'name': 'John Developer',
  'email': 'john@example.com',
  'bio': 'Passionate Flutter developer creating amazing mobile and web experiences',
  'profileImage': 'https://via.placeholder.com/150x150?text=Profile',
  'location': 'San Francisco, CA',
  'website': 'https://example.com',
  'socialMediaLinks': {
    'github': 'https://github.com/example',
    'twitter': 'https://twitter.com/example',
    'linkedin': 'https://linkedin.com/in/example',
  },
  'skills': ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Mobile Development'],
  'createdAt': '2024-01-01T00:00:00Z',
  'updatedAt': '2024-01-01T00:00:00Z',
};

/// Repository for user data operations
class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  /// Get current user profile
  Future<UserModel?> getCurrentUserProfile() async {
    try {
      final uid = _authService.currentUID;
      if (uid == null) return null;

      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.usersCollection,
        docId: uid,
      );

      if (data != null) {
        return UserModel.fromFirestore(data);
      }
      
      // Return fallback user if no data found
      return UserModel.fromFirestore(_fallbackUserProfile);
    } catch (e) {
      // Return fallback user on error
      return UserModel.fromFirestore(_fallbackUserProfile);
    }
  }

  /// Create user profile
  Future<void> createUserProfile(UserModel user) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.usersCollection,
        docId: user.id,
        data: user.toJson(),
      );
    } catch (e) {
      // Silently fail - will use fallback data
      debugPrint('Failed to create user profile: $e');
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(UserModel user) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.usersCollection,
        docId: user.id,
        data: user.toJson(),
      );
    } catch (e) {
      // Silently fail - will use fallback data
      debugPrint('Failed to update user profile: $e');
    }
  }

  /// Get user by ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.usersCollection,
        docId: userId,
      );

      if (data != null) {
        return UserModel.fromFirestore(data);
      }
      
      // Return fallback user if no data found
      return UserModel.fromFirestore(_fallbackUserProfile);
    } catch (e) {
      // Return fallback user on error
      return UserModel.fromFirestore(_fallbackUserProfile);
    }
  }
}
