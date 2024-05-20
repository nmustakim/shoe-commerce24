import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String id;
  final dynamic price;
  final int reviewCount;
  final dynamic rating;
  final String title;
  final String image;
  final String logo;

  Shoe({
    required this.image,
    required this.id,
    required this.price,
    required this.reviewCount,
    required this.rating,
    required this.title,
    required this.logo,
  });

  factory Shoe.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Shoe(
      id: doc.id,
      image: data['image'] ?? '',
      logo: data['logo'] ?? '',
      price: data['price'] ?? 0,
      reviewCount: data['review_count'] ?? 0,
      rating: data['rating'] ?? 0.0,
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'price': price,
      'review_count': reviewCount,
      'logo': logo,
      'rating': rating,
      'title': title,
      'image': image,
    };
  }
}
