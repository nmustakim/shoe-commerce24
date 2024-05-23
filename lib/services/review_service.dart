import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/review.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String reviewsCollection = 'reviews';

  // Fetch reviews by shoe ID
  Future<List<Review>> fetchReviewsByShoeId(String shoeId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(reviewsCollection)
          .where('shoesId', isEqualTo: shoeId)
          .get();

      return querySnapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        rethrow;
        print('Error fetching reviews: $e');
      }

      return [];

    }
  }

  // Fetch review by review ID
  Future<Review?> fetchReviewById(String reviewId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(reviewsCollection).doc(reviewId).get();
      if (doc.exists) {
        return Review.fromDocument(doc);
      } else {
        print('Review not found');
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching review: $e');
      }
      return null;
    }
  }

  // Fetch reviews by rating range
  Future<List<Review>> fetchReviewsInRange(String shoeId, double rating) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(reviewsCollection)
          .where('shoeId', isEqualTo: shoeId)
          .where('rating', isGreaterThanOrEqualTo: rating)
          .where('rating', isLessThan: rating + 1)
          .get();

      return querySnapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching reviews by rating: $e');
      }
      return [];
    }
  }

  // Fetch top 3 reviews by shoe ID
  Future<List<Review>> fetchTop3Reviews(String shoeId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(reviewsCollection)
          .where('shoesId', isEqualTo: shoeId)
          .orderBy('rating', descending: true)
          .limit(3)
          .get();

      return querySnapshot.docs.map((doc) => Review.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching top 3 reviews: $e');
      return [];
    }
  }
}
