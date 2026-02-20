import 'package:about_myself/models/case_study_model.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Hardcoded fallback case studies
const List<Map<String, dynamic>> _fallbackCaseStudies = [
  {
    'id': '1',
    'title': 'E-Commerce Mobile App',
    'description': 'A full-featured e-commerce platform built with Flutter',
    'content': 'Developed a complete e-commerce solution...',
    'images': ['https://via.placeholder.com/600x400?text=Ecommerce'],
    'technologies': ['Flutter', 'Firebase', 'Provider'],
    'clientName': 'TechStartup Inc.',
    'projectDuration': '3 months',
    'role': 'Lead Developer',
    'liveLink': 'https://example.com/ecommerce',
    'githubLink': 'https://github.com/example/ecommerce',
    'viewCount': 150,
    'published': true,
    'createdAt': '2024-01-15T10:00:00Z',
    'updatedAt': '2024-01-15T10:00:00Z',
  },
  {
    'id': '2',
    'title': 'Real Estate Platform',
    'description': 'Web-based real estate listing and management system',
    'content': 'Built a responsive real estate platform...',
    'images': ['https://via.placeholder.com/600x400?text=RealEstate'],
    'technologies': ['Flutter Web', 'Firestore', 'Google Maps'],
    'clientName': 'Real Estate Co.',
    'projectDuration': '4 months',
    'role': 'Full Stack Developer',
    'liveLink': 'https://example.com/realestate',
    'githubLink': 'https://github.com/example/realestate',
    'viewCount': 200,
    'published': true,
    'createdAt': '2024-01-01T10:00:00Z',
    'updatedAt': '2024-01-01T10:00:00Z',
  },
];

/// Repository for case study data operations
class CaseStudyRepository {
  final FirestoreService _firestoreService = FirestoreService();

  /// Get all published case studies
  Future<List<CaseStudyModel>> getAllCaseStudies({int limit = 20}) async {
    try {
      final data = await _firestoreService.getCollection(
        collection: FirebaseConstants.caseStudiesCollection,
        limit: limit,
        published: true,
      );

      if (data.isEmpty) {
        return _fallbackCaseStudies
            .map((json) => CaseStudyModel.fromJson(json))
            .toList();
      }

      return data
          .map((json) => CaseStudyModel.fromFirestore(json))
          .toList();
    } catch (e) {
      return _fallbackCaseStudies
          .map((json) => CaseStudyModel.fromJson(json))
          .toList();
    }
  }

  /// Get a single case study by ID
  Future<CaseStudyModel?> getCaseStudyById(String caseStudyId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.caseStudiesCollection,
        docId: caseStudyId,
      );

      if (data != null) {
        return CaseStudyModel.fromFirestore(data);
      }

      final fallback = _fallbackCaseStudies
          .where((cs) => cs['id'] == caseStudyId)
          .firstOrNull;
      return fallback != null ? CaseStudyModel.fromJson(fallback) : null;
    } catch (e) {
      final fallback = _fallbackCaseStudies
          .where((cs) => cs['id'] == caseStudyId)
          .firstOrNull;
      return fallback != null ? CaseStudyModel.fromJson(fallback) : null;
    }
  }

  /// Search case studies by technology
  Future<List<CaseStudyModel>> searchByTechnology(String tech) async {
    try {
      final all = await getAllCaseStudies();
      return all
          .where((cs) =>
              cs.technologies.any((t) =>
                  t.toLowerCase().contains(tech.toLowerCase())))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Stream case studies
  Stream<List<CaseStudyModel>> streamCaseStudies({int limit = 20}) {
    try {
      return _firestoreService
          .streamCollection(
            collection: FirebaseConstants.caseStudiesCollection,
            limit: limit,
          )
          .map((data) => data
              .map((json) => CaseStudyModel.fromFirestore(json))
              .toList());
    } catch (e) {
      return Stream.value(
        _fallbackCaseStudies
            .map((json) => CaseStudyModel.fromJson(json))
            .toList(),
      );
    }
  }

  /// Create a new case study
  Future<String> createCaseStudy(CaseStudyModel caseStudy) async {
    try {
      return await _firestoreService.createDocument(
        collection: FirebaseConstants.caseStudiesCollection,
        data: caseStudy.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create case study: $e');
    }
  }

  /// Update a case study
  Future<void> updateCaseStudy(CaseStudyModel caseStudy) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.caseStudiesCollection,
        docId: caseStudy.id,
        data: caseStudy.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update case study: $e');
    }
  }

  /// Delete a case study
  Future<void> deleteCaseStudy(String caseStudyId) async {
    try {
      await _firestoreService.deleteDocument(
        collection: FirebaseConstants.caseStudiesCollection,
        docId: caseStudyId,
      );
    } catch (e) {
      throw Exception('Failed to delete case study: $e');
    }
  }

  /// Increment view count
  Future<void> incrementViewCount(String caseStudyId) async {
    try {
      final current = await getCaseStudyById(caseStudyId);
      if (current != null) {
        await updateCaseStudy(
          current.copyWith(viewCount: (current.viewCount ?? 0) + 1),
        );
      }
    } catch (e) {
      // Silently fail for view count increment
    }
  }
}
