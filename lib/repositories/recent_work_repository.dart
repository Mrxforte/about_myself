import 'package:about_myself/models/recent_work_model.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Hardcoded fallback recent works
const List<Map<String, dynamic>> _fallbackRecentWorks = [
  {
    'id': '1',
    'title': 'Task Management App',
    'description': 'A collaborative task management application with real-time sync',
    'category': 'Mobile App',
    'images': ['https://via.placeholder.com/600x400?text=Task+App'],
    'technologies': ['Flutter', 'Firebase', 'Provider', 'Dart'],
    'liveLink': 'https://example.com/tasks',
    'githubLink': 'https://github.com/example/tasks',
    'viewCount': 120,
    'published': true,
    'createdAt': '2024-02-10T10:00:00Z',
    'updatedAt': '2024-02-10T10:00:00Z',
  },
  {
    'id': '2',
    'title': 'News Aggregator Website',
    'description': 'Responsive web platform for news aggregation and curation',
    'category': 'Web App',
    'images': ['https://via.placeholder.com/600x400?text=News+App'],
    'technologies': ['Flutter Web', 'REST API', 'Firebase', 'Responsive'],
    'liveLink': 'https://example.com/news',
    'githubLink': 'https://github.com/example/news',
    'viewCount': 180,
    'published': true,
    'createdAt': '2024-02-05T10:00:00Z',
    'updatedAt': '2024-02-05T10:00:00Z',
  },
  {
    'id': '3',
    'title': 'Fitness Tracking App',
    'description': 'Personal fitness tracker with workout history and analytics',
    'category': 'Health App',
    'images': ['https://via.placeholder.com/600x400?text=Fitness+App'],
    'technologies': ['Flutter', 'Dart', 'SQLite', 'Charts'],
    'liveLink': 'https://example.com/fitness',
    'githubLink': 'https://github.com/example/fitness',
    'viewCount': 95,
    'published': true,
    'createdAt': '2024-01-28T10:00:00Z',
    'updatedAt': '2024-01-28T10:00:00Z',
  },
];

/// Repository for recent work data operations
class RecentWorkRepository {
  final FirestoreService _firestoreService = FirestoreService();

  /// Get all published recent works
  Future<List<RecentWorkModel>> getAllRecentWorks({int limit = 20}) async {
    try {
      final data = await _firestoreService.getCollection(
        collection: FirebaseConstants.recentWorksCollection,
        limit: limit,
        published: true,
      );

      if (data.isEmpty) {
        return _fallbackRecentWorks
            .map((json) => RecentWorkModel.fromJson(json))
            .toList();
      }

      return data
          .map((json) => RecentWorkModel.fromFirestore(json))
          .toList();
    } catch (e) {
      return _fallbackRecentWorks
          .map((json) => RecentWorkModel.fromJson(json))
          .toList();
    }
  }

  /// Get a single recent work by ID
  Future<RecentWorkModel?> getRecentWorkById(String workId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.recentWorksCollection,
        docId: workId,
      );

      if (data != null) {
        return RecentWorkModel.fromFirestore(data);
      }

      final fallback = _fallbackRecentWorks
          .where((w) => w['id'] == workId)
          .firstOrNull;
      return fallback != null ? RecentWorkModel.fromJson(fallback) : null;
    } catch (e) {
      final fallback = _fallbackRecentWorks
          .where((w) => w['id'] == workId)
          .firstOrNull;
      return fallback != null ? RecentWorkModel.fromJson(fallback) : null;
    }
  }

  /// Get works by category
  Future<List<RecentWorkModel>> getWorksByCategory(String category) async {
    try {
      final all = await getAllRecentWorks();
      return all.where((w) => w.category == category).toList();
    } catch (e) {
      return [];
    }
  }

  /// Search works by technology
  Future<List<RecentWorkModel>> searchByTechnology(String tech) async {
    try {
      final all = await getAllRecentWorks();
      return all
          .where((w) =>
              w.technologies.any((t) =>
                  t.toLowerCase().contains(tech.toLowerCase())))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Stream recent works
  Stream<List<RecentWorkModel>> streamRecentWorks({int limit = 20}) {
    try {
      return _firestoreService
          .streamCollection(
            collection: FirebaseConstants.recentWorksCollection,
            limit: limit,
          )
          .map((data) =>
              data.map((json) => RecentWorkModel.fromFirestore(json)).toList());
    } catch (e) {
      return Stream.value(
        _fallbackRecentWorks
            .map((json) => RecentWorkModel.fromJson(json))
            .toList(),
      );
    }
  }

  /// Create a new recent work
  Future<String> createRecentWork(RecentWorkModel work) async {
    try {
      return await _firestoreService.createDocument(
        collection: FirebaseConstants.recentWorksCollection,
        data: work.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create recent work: $e');
    }
  }

  /// Update a recent work
  Future<void> updateRecentWork(RecentWorkModel work) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.recentWorksCollection,
        docId: work.id,
        data: work.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update recent work: $e');
    }
  }

  /// Delete a recent work
  Future<void> deleteRecentWork(String workId) async {
    try {
      await _firestoreService.deleteDocument(
        collection: FirebaseConstants.recentWorksCollection,
        docId: workId,
      );
    } catch (e) {
      throw Exception('Failed to delete recent work: $e');
    }
  }

  /// Increment view count
  Future<void> incrementViewCount(String workId) async {
    try {
      final current = await getRecentWorkById(workId);
      if (current != null) {
        await updateRecentWork(
          current.copyWith(viewCount: (current.viewCount ?? 0) + 1),
        );
      }
    } catch (e) {
      // Silently fail for view count increment
    }
  }

  /// Get all unique categories
  Future<List<String>> getAllCategories() async {
    try {
      final all = await getAllRecentWorks();
      final categories = <String>{};
      for (final work in all) {
        if (work.category != null) {
          categories.add(work.category!);
        }
      }
      return categories.toList();
    } catch (e) {
      return [];
    }
  }
}
