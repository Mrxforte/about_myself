import 'package:flutter/foundation.dart';
import 'package:about_myself/models/contact_model.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Repository for contact form submissions
class ContactRepository {
  final FirestoreService _firestoreService = FirestoreService();

  /// Submit a contact form
  Future<String> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
    String? phone,
  }) async {
    try {
      final contact = ContactModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
        isRead: false,
        submittedAt: DateTime.now(),
      );

      return await _firestoreService.createDocument(
        collection: FirebaseConstants.contactSubmissionsCollection,
        data: contact.toJson(),
      );
    } catch (e) {
      debugPrint('Failed to submit contact form: $e');
      // Return generated ID even if submission fails (offline fallback)
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  /// Get all contact submissions
  Future<List<ContactModel>> getAllSubmissions({int limit = 100}) async {
    try {
      final data = await _firestoreService.getCollection(
        collection: FirebaseConstants.contactSubmissionsCollection,
        limit: limit,
        published: false, // Contact submissions don't use published field
      );

      return data.map((json) => ContactModel.fromFirestore(json)).toList();
    } catch (e) {
      debugPrint('Failed to get submissions: $e');
      // Return empty list as fallback
      return [];
    }
  }

  /// Get a single submission
  Future<ContactModel?> getSubmission(String submissionId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.contactSubmissionsCollection,
        docId: submissionId,
      );

      return data != null ? ContactModel.fromFirestore(data) : null;
    } catch (e) {
      debugPrint('Failed to get submission: $e');
      // Return null as fallback
      return null;
    }
  }

  /// Mark submission as read
  Future<void> markAsRead(String submissionId) async {
    try {
      final submission = await getSubmission(submissionId);
      if (submission != null) {
        await _firestoreService.updateDocument(
          collection: FirebaseConstants.contactSubmissionsCollection,
          docId: submissionId,
          data: submission.copyWith(isRead: true).toJson(),
        );
      }
    } catch (e) {
      debugPrint('Failed to mark as read: $e');
      // Silently fail
    }
  }

  /// Delete a submission
  Future<void> deleteSubmission(String submissionId) async {
    try {
      await _firestoreService.deleteDocument(
        collection: FirebaseConstants.contactSubmissionsCollection,
        docId: submissionId,
      );
    } catch (e) {
      debugPrint('Failed to delete submission: $e');
      // Silently fail
    }
  }

  /// Stream contact submissions
  Stream<List<ContactModel>> streamSubmissions({int limit = 100}) {
    try {
      return _firestoreService
          .streamCollection(
            collection: FirebaseConstants.contactSubmissionsCollection,
            limit: limit,
          )
          .map((data) =>
              data.map((json) => ContactModel.fromFirestore(json)).toList());
    } catch (e) {
      debugPrint('Failed to stream submissions: $e');
      return Stream.value([]);
    }
  }
}
