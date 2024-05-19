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

  Stream<List<Shoe>> getShoes() {
    return _shoesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList();
    }).handleError((e) {
      debugPrint('Error getting shoes: $e');
      throw e;
    });
  }
}
