import 'package:flutter/foundation.dart';
import 'package:about_myself/models/recent_work_model.dart';
import 'package:about_myself/repositories/recent_work_repository.dart';

enum LoadingState { idle, loading, success, error }

/// ViewModel for Recent Works page
class RecentWorksViewModel extends ChangeNotifier {
  final RecentWorkRepository _repository = RecentWorkRepository();

  // State
  LoadingState _loadingState = LoadingState.idle;
  List<RecentWorkModel> _recentWorks = [];
  List<RecentWorkModel> _filteredWorks = [];
  RecentWorkModel? _selectedWork;
  String _errorMessage = '';
  String _selectedCategory = '';
  String _selectedTechnology = '';
  List<String> _categories = [];

  // Getters
  LoadingState get loadingState => _loadingState;
  List<RecentWorkModel> get recentWorks =>
      _filteredWorks.isEmpty ? _recentWorks : _filteredWorks;
  RecentWorkModel? get selectedWork => _selectedWork;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get selectedTechnology => _selectedTechnology;
  List<String> get categories => _categories;

  bool get isLoading => _loadingState == LoadingState.loading;

  /// Load all recent works
  Future<void> loadRecentWorks() async {
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      _recentWorks = await _repository.getAllRecentWorks();
      _categories = await _repository.getAllCategories();
      _filteredWorks = [];
      _loadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Load single work by ID
  Future<void> loadWorkById(String id) async {
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      _selectedWork = await _repository.getRecentWorkById(id);
      await _repository.incrementViewCount(id);
      _loadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Filter by category
  Future<void> filterByCategory(String category) async {
    _selectedCategory = category;
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      if (category.isEmpty) {
        _filteredWorks = [];
      } else {
        _filteredWorks = await _repository.getWorksByCategory(category);
      }
      _loadingState = LoadingState.success;
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Filter by technology
  Future<void> filterByTechnology(String technology) async {
    _selectedTechnology = technology;
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      if (technology.isEmpty) {
        _filteredWorks = [];
      } else {
        _filteredWorks = await _repository.searchByTechnology(technology);
      }
      _loadingState = LoadingState.success;
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Clear filters
  void clearFilters() {
    _selectedCategory = '';
    _selectedTechnology = '';
    _filteredWorks = [];
    notifyListeners();
  }

  /// Refresh recent works
  Future<void> refreshRecentWorks() async {
    await loadRecentWorks();
  }

  /// Clear selected work
  void clearSelectedWork() {
    _selectedWork = null;
    notifyListeners();
  }
}
