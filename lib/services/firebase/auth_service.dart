import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_service.dart';

/// Authentication service for Firebase Auth
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 

  /// Get current user
  User? get currentUser {
    try {
      if (!FirebaseService.isAvailable) return null;
      return _firebaseAuth.currentUser;
    } catch (e) {
      debugPrint('Auth error: $e');
      return null;
    }
  }

  /// Get current UID
  String? get currentUID {
    try {
      if (!FirebaseService.isAvailable) return null;
      return _firebaseAuth.currentUser?.uid;
    } catch (e) {
      debugPrint('Auth error: $e');
      return null;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    try {
      if (!FirebaseService.isAvailable) return false;
      return _firebaseAuth.currentUser != null;
    } catch (e) {
      debugPrint('Auth error: $e');
      return false;
    }
  }

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges {
    try {
      if (!FirebaseService.isAvailable) {
        return Stream.value(null); // Return empty stream
      }
      return _firebaseAuth.authStateChanges();
    } catch (e) {
      debugPrint('Auth error: $e');
      return Stream.value(null);
    }
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        throw Exception('Firebase is not available. Cannot sign up.');
      }

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user?.updateDisplayName(displayName);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        throw Exception('Firebase is not available. Cannot sign in.');
      }

      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      if (!FirebaseService.isAvailable) {
        debugPrint('Firebase is not available. Sign out skipped.');
        return;
      }

      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      debugPrint('Sign out error: $e');
      // Silently fail
    }
  }

  /// Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      if (!FirebaseService.isAvailable) {
        throw Exception('Firebase is not available. Cannot reset password.');
      }

      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        debugPrint('Firebase is not available. Update skipped.');
        return;
      }

      await currentUser?.updateDisplayName(displayName);
      if (photoURL != null) {
        await currentUser?.updatePhotoURL(photoURL);
      }
      await currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Handle Firebase Auth exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'email-already-in-use':
        return Exception('Email already registered');
      case 'invalid-email':
        return Exception('Invalid email address');
      case 'operation-not-allowed':
        return Exception('This operation is not allowed');
      case 'too-many-requests':
        return Exception('Too many login attempts. Please try again later');
      case 'invalid-credential':
        return Exception('Invalid credentials');
      default:
        return Exception('Authentication error: ${e.message}');
    }
  }
}
