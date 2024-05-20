import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/shoe.dart';

class ShoesService {
  final CollectionReference _shoesCollection;

  ShoesService(FirebaseFirestore firestore)
      : _shoesCollection = firestore.collection('shoes');

  Future<void> addShoe(Shoe shoe) async {
    try {
      await _shoesCollection.add(shoe.toDocument());
    } catch (e) {
      debugPrint('Error adding shoe: $e');
      rethrow;
    }
  }

  Future<void> updateShoe(Shoe shoe) async {
    try {
      await _shoesCollection.doc(shoe.id).update(shoe.toDocument());
    } catch (e) {
      debugPrint('Error updating shoe: $e');
      rethrow;
    }
  }

  Future<void> deleteShoe(String id) async {
    try {
      await _shoesCollection.doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting shoe: $e');
      rethrow;
    }
  }

  Future<ShoesResult> getShoes() async {
    final querySnapshot = await _shoesCollection.limit(6).get();
    final shoes = querySnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList();
    final lastDocument = querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
    return ShoesResult(shoes, lastDocument);
  }

  Future<ShoesResult> getMoreShoes(DocumentSnapshot lastDocument) async {
    final querySnapshot = await _shoesCollection.startAfterDocument(lastDocument).limit(10).get();
    final shoes = querySnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList();
    final newLastDocument = querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
    return ShoesResult(shoes, newLastDocument);
  }
}

class ShoesResult {
  final List<Shoe> shoes;
  final DocumentSnapshot? lastDocument;

  ShoesResult(this.shoes, this.lastDocument);
}
