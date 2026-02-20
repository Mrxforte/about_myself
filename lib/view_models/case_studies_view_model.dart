import 'package:flutter/foundation.dart';
import 'package:about_myself/models/case_study_model.dart';
import 'package:about_myself/repositories/case_study_repository.dart';

enum LoadingState { idle, loading, success, error }

/// ViewModel for Case Studies page
class CaseStudiesViewModel extends ChangeNotifier {
  final CaseStudyRepository _repository = CaseStudyRepository();

  // State
  LoadingState _loadingState = LoadingState.idle;
  List<CaseStudyModel> _caseStudies = [];
  List<CaseStudyModel> _filteredCaseStudies = [];
  CaseStudyModel? _selectedCaseStudy;
  String _errorMessage = '';
  String _selectedTechnology = '';

  // Getters
  LoadingState get loadingState => _loadingState;
  List<CaseStudyModel> get caseStudies => _filteredCaseStudies.isEmpty ? _caseStudies : _filteredCaseStudies;
  CaseStudyModel? get selectedCaseStudy => _selectedCaseStudy;
  String get errorMessage => _errorMessage;
  String get selectedTechnology => _selectedTechnology;

  bool get isLoading => _loadingState == LoadingState.loading;

  /// Load all case studies
  Future<void> loadCaseStudies() async {
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      _caseStudies = await _repository.getAllCaseStudies();
      _filteredCaseStudies = [];
      _loadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Load single case study by ID
  Future<void> loadCaseStudyById(String id) async {
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      _selectedCaseStudy = await _repository.getCaseStudyById(id);
      await _repository.incrementViewCount(id);
      _loadingState = LoadingState.success;
      _errorMessage = '';
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
        _filteredCaseStudies = [];
      } else {
        _filteredCaseStudies =
            await _repository.searchByTechnology(technology);
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
    _selectedTechnology = '';
    _filteredCaseStudies = [];
    notifyListeners();
  }

  /// Refresh case studies
  Future<void> refreshCaseStudies() async {
    await loadCaseStudies();
  }

  /// Clear selected case study
  void clearSelectedCaseStudy() {
    _selectedCaseStudy = null;
    notifyListeners();
  }
}
