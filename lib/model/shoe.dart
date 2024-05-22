import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String id;
  final String logo;
  final String name;
  final String brand;
  final String description;
  final double price;
  final int reviewCount;
  final double averageRating;
  final List<String> images;
  final List<Review> reviews;
  final List<String> colors;
  final List<double> sizes;

  Shoe({required this.brand,
    required this.id,
    required this.description,
    required this.images,
    required this.logo,
    required this.name,
    required this.price,
    required this.reviewCount,
    required this.averageRating,
    required this.reviews,
    required this.colors,
    required this.sizes,
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
      logo: data['logo'] ?? '',
      name: data['title'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      reviewCount: data['review_count'] ?? 0,
      averageRating: (data['avg_rating'] ?? 0.0).toDouble(),
      reviews: reviews,
      images: List<String>.from(data['image'] ?? []),
      colors: List<String>.from(data['colors'] ?? []),
      sizes: List<double>.from((data['sizes'] ?? []).map((size) => size.toDouble())),
      description: data['description'] ?? '', brand: data['brand']??'',
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
