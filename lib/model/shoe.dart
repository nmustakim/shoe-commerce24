import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String id;
  final String image;
  final String logo;
  final String name;
  final double price;
  final int reviewCount;
  final double averageRating;
  final List<Review> reviews;

  Shoe({
    required this.id,
    required this.image,
    required this.logo,
    required this.name,
    required this.price,
    required this.reviewCount,
    required this.averageRating,
    required this.reviews,
  });

  factory Shoe.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<Review> reviews = [];
    if (data['reviews'] != null) {
      data['reviews'].forEach((reviewData) {
        reviews.add(Review.fromMap(reviewData));
      });
    }
    return Shoe(
      id: doc.id,
      image: data['image'] ?? '',
      logo: data['logo'] ?? '',
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      averageRating: (data['averageRating'] ?? 0.0).toDouble(),
      reviews: reviews,
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final Timestamp timestamp;
  final String userId;

  Review({
    required this.rating,
    required this.comment,
    required this.timestamp,
    required this.userId,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] ?? 0,
      comment: map['comment'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      userId: map['userId'] ?? '',
    );
  }
}
