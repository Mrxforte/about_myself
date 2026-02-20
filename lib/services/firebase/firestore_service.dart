import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:about_myself/config/firebase_constants.dart';
import 'firebase_service.dart';

/// Firestore database service
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Generic fetch documents from a collection
  Future<List<Map<String, dynamic>>> getCollection({
    required String collection,
    int limit = 100,
    bool published = true,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        return []; // Return empty list to trigger fallback in repositories
      }

      Query query = _db.collection(collection);

      // Filter by published status if field exists
      query = query.where(FirebaseConstants.publishedField, isEqualTo: published);

      // Order by timestamp
      query = query.orderBy(
        FirebaseConstants.createdAtField,
        descending: true,
      );

      // Limit results
      query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();
    } catch (e) {
      debugPrint('Firestore error: $e');
      return []; // Return empty list to trigger fallback in repositories
    }
  }

  /// Fetch a single document
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        return null; // Return null to trigger fallback in repositories
      }

      final snapshot = await _db.collection(collection).doc(docId).get();
      if (snapshot.exists) {
        return {...snapshot.data() as Map<String, dynamic>, 'id': snapshot.id};
      }
      return null;
    } catch (e) {
      debugPrint('Firestore error: $e');
      return null; // Return null to trigger fallback in repositories
    }
  }

  /// Create a new document
  Future<String> createDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        // Generate a local ID when Firebase is unavailable
        return DateTime.now().millisecondsSinceEpoch.toString();
      }

      final docRef = await _db.collection(collection).add({
        ...data,
        FirebaseConstants.createdAtField: FieldValue.serverTimestamp(),
        FirebaseConstants.updatedAtField: FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      debugPrint('Firestore error: $e');
      // Generate a local ID as fallback
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  /// Update a document
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        debugPrint('Firebase is unavailable. Update skipped.');
        return;
      }

      await _db.collection(collection).doc(docId).update({
        ...data,
        FirebaseConstants.updatedAtField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Firestore error: $e');
      // Silently fail when Firebase is unavailable
    }
  }

  /// Delete a document
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        debugPrint('Firebase is unavailable. Delete skipped.');
        return;
      }

      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      debugPrint('Firestore error: $e');
      // Silently fail when Firebase is unavailable
    }
  }

  /// Stream documents from a collection
  Stream<List<Map<String, dynamic>>> streamCollection({
    required String collection,
    int limit = 100,
  }) {
    try {
      if (!FirebaseService.isAvailable) {
        return Stream.value([]); // Return empty stream
      }

      return _db
          .collection(collection)
          .orderBy(FirebaseConstants.createdAtField, descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs
                  .map((doc) =>
                      {...doc.data(), 'id': doc.id})
                  .toList());
    } catch (e) {
      debugPrint('Firestore error: $e');
      return Stream.value([]); // Return empty stream
    }
  }

  /// Batch write operations
  Future<void> batchWrite(Function(WriteBatch) fn) async {
    try {
      if (!FirebaseService.isAvailable) {
        debugPrint('Firebase is unavailable. Batch write skipped.');
        return;
      }

      WriteBatch batch = _db.batch();
      fn(batch);
      await batch.commit();
    } catch (e) {
      debugPrint('Firestore error: $e');
      // Silently fail when Firebase is unavailable
    }
  }

  /// Search documents by field
  Future<List<Map<String, dynamic>>> searchByField({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      if (!FirebaseService.isAvailable) {
        return []; // Return empty list to trigger fallback
      }

      final snapshot = await _db
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();

      return snapshot.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      debugPrint('Firestore error: $e');
      return []; // Return empty list to trigger fallback
    }
  }
}
