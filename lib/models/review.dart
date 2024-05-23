import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String comment;
  final double rating;
  final String shoesId;
  final Timestamp timestamp;
  final String username;

  Review({
    required this.id,
    required this.comment,
    required this.rating,
    required this.shoesId,
    required this.timestamp,
    required this.username,
  });

  factory Review.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      comment: data['comment'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      shoesId: data['shoesId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'rating': rating,
      'shoesId': shoesId,
      'timestamp': timestamp,
      'username': username,
    };
  }
}
