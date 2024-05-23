import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String id;
  final String logo;
  final String name;
  final String gender;
  final String brand;
  final String description;
  final double price;
  final int reviewCount;
  final double averageRating;
  final List<String> images;
  final List<String> colors;
  final List<double> sizes;

  Shoe({
    required this.id,
    required this.logo,
    required this.name,
    required this.gender,
    required this.brand,
    required this.description,
    required this.price,
    required this.reviewCount,
    required this.averageRating,
    required this.images,
    required this.colors,
    required this.sizes,
  });

  factory Shoe.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Shoe(
      id: doc.id,
      logo: data['logo'] ?? '',
      name: data['title'] ?? '',
      gender: data['gender'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      reviewCount: data['review_count'] ?? 0,
      averageRating: (data['avg_rating'] ?? 0.0).toDouble(),
      images: List<String>.from(data['image'] ?? []),
      colors: List<String>.from(data['colors'] ?? []),
      sizes: List<double>.from(
          (data['sizes'] ?? []).map((size) => size.toDouble())),
      description: data['description'] ?? '',
      brand: data['brand'] ?? '',
    );
  }
}
