
import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  final String id;

  final double price;
  final int reviewCount;
  final double rating;
  final String title;
  final String image;


  Shoe({required this.image, required this.id, required this.price, required this.reviewCount, required this.rating, required this.title});

  factory Shoe.fromDocument(DocumentSnapshot doc) {
    return Shoe(
      id: doc.id,

      image: doc['image'],
      price: doc['price'],
      reviewCount: doc['review_count'],
      rating: doc['rating'],
      title: doc['title'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {

      'price': price,
      'review_count': reviewCount,
      'rating': rating,
      'title': title,
      'image':image
    };
  }
}

