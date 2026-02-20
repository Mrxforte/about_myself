import 'package:flutter/foundation.dart';
import 'package:about_myself/repositories/contact_repository.dart';

enum SubmissionState { idle, loading, success, error }

/// ViewModel for Get In Touch page (Contact form)
class GetInTouchViewModel extends ChangeNotifier {
  final ContactRepository _repository = ContactRepository();

  // State
  SubmissionState _submissionState = SubmissionState.idle;
  String _errorMessage = '';
  String _successMessage = '';

  // Form data
  String _name = '';
  String _email = '';
  String _phone = '';
  String _subject = '';
  String _message = '';

  // Getters
  SubmissionState get submissionState => _submissionState;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  bool get isLoading => _submissionState == SubmissionState.loading;
  bool get hasError => _submissionState == SubmissionState.error;
  bool get isSuccess => _submissionState == SubmissionState.success;

  bool get isFormValid =>
      _name.isNotEmpty &&
      _email.isNotEmpty &&
      _subject.isNotEmpty &&
      _message.isNotEmpty &&
      _isValidEmail(_email);

  /// Validate email
  bool _isValidEmail(String value) {
    final regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(value);
  }

  /// Update name
  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  /// Update email
  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  /// Update phone
  void updatePhone(String value) {
    _phone = value;
    notifyListeners();
  }

  /// Update subject
  void updateSubject(String value) {
    _subject = value;
    notifyListeners();
  }

  /// Update message
  void updateMessage(String value) {
    _message = value;
    notifyListeners();
  }

  /// Submit contact form
  Future<void> submitForm() async {
    if (!isFormValid) {
      _submissionState = SubmissionState.error;
      _errorMessage = 'Please fill all fields correctly';
      notifyListeners();
      return;
    }

    _submissionState = SubmissionState.loading;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      await _repository.submitContactForm(
        name: _name,
        email: _email,
        phone: _phone,
        subject: _subject,
        message: _message,
      );

      _submissionState = SubmissionState.success;
      _successMessage = 'Thank you! Your message has been sent successfully.';
      resetForm();
    } catch (e) {
      _submissionState = SubmissionState.error;
      _errorMessage = 'Failed to submit form: ${e.toString()}';
    }
    notifyListeners();
  }

  /// Reset form
  void resetForm() {
    _name = '';
    _email = '';
    _phone = '';
    _subject = '';
    _message = '';
    notifyListeners();
  }

  /// Clear messages
  void clearMessages() {
    _errorMessage = '';
    _successMessage = '';
    _submissionState = SubmissionState.idle;
    notifyListeners();
  }
}
