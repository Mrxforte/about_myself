import 'package:about_myself/models/blog_model.dart';
import 'package:about_myself/services/firebase/firestore_service.dart';
import 'package:about_myself/config/firebase_constants.dart';

/// Hardcoded fallback blog data for offline use
const List<Map<String, dynamic>> _fallbackBlogs = [
  {
    'id': '1',
    'title': 'Getting Started with Flutter Web',
    'excerpt': 'Learn how to build responsive web apps with Flutter',
    'content': 'Flutter is a powerful framework for building beautiful applications across platforms...',
    'imageUrl': 'https://via.placeholder.com/600x400?text=Flutter+Web',
    'tags': ['flutter', 'web', 'mobile'],
    'published': true,
    'publishedDate': '2024-02-15T10:00:00Z',
    'createdAt': '2024-02-15T10:00:00Z',
    'updatedAt': '2024-02-15T10:00:00Z',
  },
  {
    'id': '2',
    'title': 'MVVM Architecture in Flutter',
    'excerpt': 'Building scalable applications with proper architecture',
    'content': 'MVVM (Model-View-ViewModel) is a powerful architectural pattern...',
    'imageUrl': 'https://via.placeholder.com/600x400?text=MVVM',
    'tags': ['architecture', 'flutter', 'mvvm'],
    'published': true,
    'publishedDate': '2024-02-10T12:30:00Z',
    'createdAt': '2024-02-10T12:30:00Z',
    'updatedAt': '2024-02-10T12:30:00Z',
  },
];

/// Repository for blog data operations
class BlogRepository {
  final FirestoreService _firestoreService = FirestoreService();

  /// Get all published blog posts
  Future<List<BlogModel>> getAllBlogs({int limit = 20}) async {
    try {
      final data = await _firestoreService.getCollection(
        collection: FirebaseConstants.blogPostsCollection,
        limit: limit,
        published: true,
      );

      if (data.isEmpty) {
        // Return fallback data if Firestore is empty
        return _fallbackBlogs
            .map((json) => BlogModel.fromJson(json))
            .toList();
      }

      return data.map((json) => BlogModel.fromFirestore(json)).toList();
    } catch (e) {
      // Fallback to hardcoded data on error
      return _fallbackBlogs
          .map((json) => BlogModel.fromJson(json))
          .toList();
    }
  }

  /// Get a single blog by ID
  Future<BlogModel?> getBlogById(String blogId) async {
    try {
      final data = await _firestoreService.getDocument(
        collection: FirebaseConstants.blogPostsCollection,
        docId: blogId,
      );

      if (data != null) {
        return BlogModel.fromFirestore(data);
      }

      // Try to find in fallback data
      final fallbackBlog = _fallbackBlogs
          .where((blog) => blog['id'] == blogId)
          .firstOrNull;
      return fallbackBlog != null ? BlogModel.fromJson(fallbackBlog) : null;
    } catch (e) {
      // Fallback to hardcoded data on error
      final fallbackBlog = _fallbackBlogs
          .where((blog) => blog['id'] == blogId)
          .firstOrNull;
      return fallbackBlog != null ? BlogModel.fromJson(fallbackBlog) : null;
    }
  }

  /// Search blogs by tag
  Future<List<BlogModel>> searchByTag(String tag) async {
    try {
      return await getAllBlogs();
      // Filter locally by tag (Firestore array-contains would require index)
    } catch (e) {
      return [];
    }
  }

  /// Stream blog posts
  Stream<List<BlogModel>> streamBlogs({int limit = 20}) {
    try {
      return _firestoreService
          .streamCollection(
            collection: FirebaseConstants.blogPostsCollection,
            limit: limit,
          )
          .map((data) =>
              data.map((json) => BlogModel.fromFirestore(json)).toList());
    } catch (e) {
      // Return stream of fallback data
      return Stream.value(
        _fallbackBlogs.map((json) => BlogModel.fromJson(json)).toList(),
      );
    }
  }

  /// Create a new blog post
  Future<String> createBlog(BlogModel blog) async {
    try {
      return await _firestoreService.createDocument(
        collection: FirebaseConstants.blogPostsCollection,
        data: blog.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create blog: $e');
    }
  }

  /// Update a blog post
  Future<void> updateBlog(BlogModel blog) async {
    try {
      await _firestoreService.updateDocument(
        collection: FirebaseConstants.blogPostsCollection,
        docId: blog.id,
        data: blog.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update blog: $e');
    }
  }

  /// Delete a blog post
  Future<void> deleteBlog(String blogId) async {
    try {
      await _firestoreService.deleteDocument(
        collection: FirebaseConstants.blogPostsCollection,
        docId: blogId,
      );
    } catch (e) {
      throw Exception('Failed to delete blog: $e');
    }
  }
}
