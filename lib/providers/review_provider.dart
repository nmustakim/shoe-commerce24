import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/review.dart';
import '../services/review_service.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewService _reviewService = ReviewService();
  List<Review> _reviews = [];
  List<Review> _topReviews = [];
  List<Review> _filteredReviews = [];

  List<Review> get topReviews => _topReviews;
  List<Review> get reviews => _reviews;
  List<Review> get filteredReviews => _filteredReviews;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFetchingTopReviews = false;
  bool get isFetchingTop => _isFetchingTopReviews;
  Future<void> fetchReviews(String shoeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _reviews = await _reviewService.fetchReviewsByShoeId(shoeId);
      _filteredReviews = _reviews;
      debugPrint('Fetched ${_reviews.length} reviews.');
    } catch (e) {
      showToast('Error fetching reviews!');
      debugPrint('Error fetching reviews: $e');
      _reviews = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getReviewsByStar({
    required String shoeId,
    int? rating,
  }) async {
    // Fetch reviews if not already fetched
    if (_reviews.isEmpty) {
      await fetchReviews(shoeId);
    }

    // Filter reviews by star rating
    _filteredReviews = rating != null
        ? _reviews.where((review) => review.rating == rating).toList()
        : _reviews;

    notifyListeners();
  }


  Future<void> fetchTop3Reviews(String shoeId) async {
    _isFetchingTopReviews = true;
    notifyListeners();

    try {
      _topReviews = await _reviewService.fetchTop3Reviews(shoeId);
      debugPrint('Fetched top 3 reviews.');
    } catch (e) {
      showToast('Error fetching reviews!');
      debugPrint('Error fetching top 3 reviews: $e');
      _topReviews = [];
    } finally {
      _isFetchingTopReviews = false;
      notifyListeners();
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
