import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:about_myself/services/firebase/auth_service.dart';

enum AuthState { unauthenticated, authenticated, loading, error }

/// ViewModel for Authentication
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  late StreamSubscription<User?> _authStateSubscription;

  // State
  AuthState _authState = AuthState.unauthenticated;
  User? _currentUser;
  String _errorMessage = '';

  // Getters
  AuthState get authState => _authState;
  User? get currentUser => _currentUser;
  String? get currentUID => _authService.currentUID;
  String get errorMessage => _errorMessage;

  bool get isAuthenticated => _authState == AuthState.authenticated;
  bool get isLoading => _authState == AuthState.loading;

  /// Stream auth state changes
  Stream<User?> get authStateStream => _authService.authStateChanges;

  /// Initialize auth state on app startup
  void initializeAuth() {
    _authStateSubscription = _authService.authStateChanges.listen((user) {
      _currentUser = user;
      if (user != null) {
        _authState = AuthState.authenticated;
      } else {
        _authState = AuthState.unauthenticated;
      }
      notifyListeners();
    });
  }

  /// Sign up with email
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    _authState = AuthState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final userCredential = await _authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: name,
      );

      _currentUser = userCredential.user;
      _authState = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Sign in with email
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _authState = AuthState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final userCredential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      _currentUser = userCredential.user;
      _authState = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }


  /// Sign out
  Future<void> signOut() async {
    _authState = AuthState.loading;
    notifyListeners();

    try {
      await _authService.signOut();
      _currentUser = null;
      _authState = AuthState.unauthenticated;
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Reset password
  Future<bool> resetPassword({required String email}) async {
    _authState = AuthState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      await _authService.resetPassword(email: email);
      _authState = AuthState.unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
