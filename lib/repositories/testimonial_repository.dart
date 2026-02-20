import 'package:about_myself/models/testimonial_model.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Hardcoded fallback testimonials
const List<Map<String, dynamic>> _fallbackTestimonials = [
  {
    'id': '1',
    'authorName': 'John Doe',
    'authorRole': 'Product Manager',
    'authorCompany': 'Tech Startup Inc.',
    'authorImage': 'https://via.placeholder.com/100x100?text=John',
    'content': 'Working with this developer was an absolute pleasure. The attention to detail and commitment to quality was outstanding.',
    'rating': 5.0,
    'published': true,
    'createdAt': '2024-02-01T10:00:00Z',
    'updatedAt': '2024-02-01T10:00:00Z',
  },
  {
    'id': '2',
    'authorName': 'Jane Smith',
    'authorRole': 'CEO',
    'authorCompany': 'Design Agency',
    'authorImage': 'https://via.placeholder.com/100x100?text=Jane',
    'content': 'Excellent project delivery and great communication throughout. Highly recommended!',
    'rating': 5.0,
    'published': true,
    'createdAt': '2024-01-15T10:00:00Z',
    'updatedAt': '2024-01-15T10:00:00Z',
  },
  {
    'id': '3',
    'authorName': 'Mike Johnson',
    'authorRole': 'CTO',
    'authorCompany': 'Digital Solutions',
    'authorImage': 'https://via.placeholder.com/100x100?text=Mike',
    'content': 'Professional, responsive, and delivered beyond expectations. A true asset to any team.',
    'rating': 5.0,
    'published': true,
    'createdAt': '2024-01-01T10:00:00Z',
    'updatedAt': '2024-01-01T10:00:00Z',
  },
];

/// Repository for testimonial data operations
class TestimonialRepository {
  final FirestoreService _firestoreService = FirestoreService();

  /// Get all published testimonials
  Future<List<TestimonialModel>> getAllTestimonials({int limit = 20}) async {
    try {
      final data = await _firestoreService.getCollection(
        collection: FirebaseConstants.testimonialsCollection,
        limit: limit,
        published: true,
      );

      if (data.isEmpty) {
        return _fallbackTestimonials
            .map((json) => TestimonialModel.fromJson(json))
            .toList();
      }

      return data
          .map((json) => TestimonialModel.fromFirestore(json))
          .toList();
    } catch (e) {
      return _fallbackTestimonials
          .map((json) => TestimonialModel.fromJson(json))
          .toList();
    }
  }

  /// Get a single testimonial by ID
  Future<TestimonialModel?> getTestimonialById(String testimonialId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.testimonialsCollection,
        docId: testimonialId,
      );

      if (data != null) {
        return TestimonialModel.fromFirestore(data);
      }

      final fallback = _fallbackTestimonials
          .where((t) => t['id'] == testimonialId)
          .firstOrNull;
      return fallback != null ? TestimonialModel.fromJson(fallback) : null;
    } catch (e) {
      final fallback = _fallbackTestimonials
          .where((t) => t['id'] == testimonialId)
          .firstOrNull;
      return fallback != null ? TestimonialModel.fromJson(fallback) : null;
    }
  }

  /// Stream testimonials
  Stream<List<TestimonialModel>> streamTestimonials({int limit = 20}) {
    try {
      return _firestoreService
          .streamCollection(
            collection: FirebaseConstants.testimonialsCollection,
            limit: limit,
          )
          .map((data) => data
              .map((json) => TestimonialModel.fromFirestore(json))
              .toList());
    } catch (e) {
      return Stream.value(
        _fallbackTestimonials
            .map((json) => TestimonialModel.fromJson(json))
            .toList(),
      );
    }
  }

  /// Create a new testimonial
  Future<String> createTestimonial(TestimonialModel testimonial) async {
    try {
      return await _firestoreService.createDocument(
        collection: FirebaseConstants.testimonialsCollection,
        data: testimonial.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create testimonial: $e');
    }
  }

  /// Update a testimonial
  Future<void> updateTestimonial(TestimonialModel testimonial) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.testimonialsCollection,
        docId: testimonial.id,
        data: testimonial.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update testimonial: $e');
    }
  }

  /// Delete a testimonial
  Future<void> deleteTestimonial(String testimonialId) async {
    try {
      await _firestoreService.deleteDocument(
        collection: FirebaseConstants.testimonialsCollection,
        docId: testimonialId,
      );
    } catch (e) {
      throw Exception('Failed to delete testimonial: $e');
    }
  }
}
