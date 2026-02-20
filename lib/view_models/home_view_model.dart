import 'package:flutter/foundation.dart';
import 'package:about_myself/models/blog_model.dart';
import 'package:about_myself/models/recent_work_model.dart';
import 'package:about_myself/repositories/blog_repository.dart';
import 'package:about_myself/repositories/recent_work_repository.dart';

enum LoadingState { idle, loading, success, error }

/// ViewModel for Home page
class HomeViewModel extends ChangeNotifier {
  final BlogRepository _blogRepository = BlogRepository();
  final RecentWorkRepository _recentWorkRepository = RecentWorkRepository();

  // State
  LoadingState _blogsLoadingState = LoadingState.idle;
  LoadingState _worksLoadingState = LoadingState.idle;
  List<BlogModel> _blogs = [];
  List<RecentWorkModel> _recentWorks = [];
  String _errorMessage = '';

  // Getters
  LoadingState get blogsLoadingState => _blogsLoadingState;
  LoadingState get worksLoadingState => _worksLoadingState;
  List<BlogModel> get blogs => _blogs;
  List<RecentWorkModel> get recentWorks => _recentWorks;
  String get errorMessage => _errorMessage;

  bool get isLoading =>
      _blogsLoadingState == LoadingState.loading ||
      _worksLoadingState == LoadingState.loading;

  /// Initialize home data
  Future<void> initializeHome() async {
    await Future.wait([
      loadBlogs(),
      loadRecentWorks(),
    ]);
  }

  /// Load featured blogs
  Future<void> loadBlogs() async {
    _blogsLoadingState = LoadingState.loading;
    notifyListeners();

    try {
      _blogs = await _blogRepository.getAllBlogs(limit: 3);
      _blogsLoadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _blogsLoadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Load recent works
  Future<void> loadRecentWorks() async {
    _worksLoadingState = LoadingState.loading;
    notifyListeners();

    try {
      _recentWorks = await _recentWorkRepository.getAllRecentWorks(limit: 6);
      _worksLoadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _worksLoadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Refresh all data
  Future<void> refreshHome() async {
    await initializeHome();
  }
}
