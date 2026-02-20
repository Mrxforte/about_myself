import 'package:flutter/foundation.dart';
import 'package:about_myself/models/testimonial_model.dart';
import 'package:about_myself/repositories/testimonial_repository.dart';

enum LoadingState { idle, loading, success, error }

/// ViewModel for Testimonials page
class TestimonialsViewModel extends ChangeNotifier {
  final TestimonialRepository _repository = TestimonialRepository();

  // State
  LoadingState _loadingState = LoadingState.idle;
  List<TestimonialModel> _testimonials = [];
  int _currentCarouselIndex = 0;
  String _errorMessage = '';

  // Getters
  LoadingState get loadingState => _loadingState;
  List<TestimonialModel> get testimonials => _testimonials;
  int get currentCarouselIndex => _currentCarouselIndex;
  String get errorMessage => _errorMessage;

  bool get isLoading => _loadingState == LoadingState.loading;

  /// Load all testimonials
  Future<void> loadTestimonials() async {
    _loadingState = LoadingState.loading;
    notifyListeners();

    try {
      _testimonials = await _repository.getAllTestimonials();
      _loadingState = LoadingState.success;
      _errorMessage = '';
    } catch (e) {
      _loadingState = LoadingState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Update carousel index
  void updateCarouselIndex(int index) {
    if (index >= 0 && index < _testimonials.length) {
      _currentCarouselIndex = index;
      notifyListeners();
    }
  }

  /// Get current testimonial
  TestimonialModel? get currentTestimonial {
    if (_testimonials.isEmpty) return null;
    return _testimonials[_currentCarouselIndex];
  }

  /// Get average rating
  double get averageRating {
    if (_testimonials.isEmpty) return 0;
    final total = _testimonials.fold<double>(
      0,
      (sum, t) => sum + t.rating,
    );
    return total / _testimonials.length;
  }

  /// Refresh testimonials
  Future<void> refreshTestimonials() async {
    _currentCarouselIndex = 0;
    await loadTestimonials();
  }

  /// Go to next testimonial
  void nextTestimonial() {
    if (_currentCarouselIndex < _testimonials.length - 1) {
      _currentCarouselIndex++;
      notifyListeners();
    }
  }

  /// Go to previous testimonial
  void previousTestimonial() {
    if (_currentCarouselIndex > 0) {
      _currentCarouselIndex--;
      notifyListeners();
    }
  }
}
