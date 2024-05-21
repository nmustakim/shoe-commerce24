import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/shoe.dart';

class ShoesService {
  final CollectionReference _brandsCollection;

  ShoesService(FirebaseFirestore firestore)
      : _brandsCollection = firestore.collection('brands');

  Future<void> deleteShoe(String brandId, String shoeId) async {
    try {
      await _brandsCollection.doc(brandId).collection('shoes').doc(shoeId).delete();
    } catch (e) {
      debugPrint('Error deleting shoe: $e');
      rethrow;
    }
  }

  Future<ShoesResult> getShoes({DocumentSnapshot? lastBrandDocument, DocumentSnapshot? lastShoeDocument}) async {
    List<Shoe> shoes = [];
    QuerySnapshot brandSnapshot;

    if (lastBrandDocument == null) {
      brandSnapshot = await _brandsCollection.limit(1).get();
    } else {
      brandSnapshot = await _brandsCollection.startAfterDocument(lastBrandDocument).limit(1).get();
    }

    if (brandSnapshot.docs.isEmpty) {
      return ShoesResult([], null, null);
    }

    DocumentSnapshot brandDoc = brandSnapshot.docs.first;
    QuerySnapshot shoeSnapshot;

    if (lastShoeDocument == null) {
      shoeSnapshot = await brandDoc.reference.collection('shoes').limit(10).get();
    } else {
      shoeSnapshot = await brandDoc.reference.collection('shoes').startAfterDocument(lastShoeDocument).limit(10).get();
    }

    shoes.addAll(shoeSnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());

    DocumentSnapshot? newLastBrandDocument = brandDoc;
    DocumentSnapshot? newLastShoeDocument = shoeSnapshot.docs.isNotEmpty ? shoeSnapshot.docs.last : null;

    while (shoes.length < 6 && newLastBrandDocument != null) {
      QuerySnapshot nextBrandSnapshot = await _brandsCollection.startAfterDocument(newLastBrandDocument).limit(1).get();
      if (nextBrandSnapshot.docs.isNotEmpty) {
        newLastBrandDocument = nextBrandSnapshot.docs.first;
        newLastShoeDocument = null;
        shoeSnapshot = await newLastBrandDocument.reference.collection('shoes').limit(10 - shoes.length).get();
        shoes.addAll(shoeSnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());
        newLastShoeDocument = shoeSnapshot.docs.isNotEmpty ? shoeSnapshot.docs.last : null;
      } else {
        newLastBrandDocument = null;
      }
    }

    return ShoesResult(shoes, newLastBrandDocument, newLastShoeDocument);
  }

  Future<ShoesResult> getMoreShoes(DocumentSnapshot lastBrandDocument, DocumentSnapshot lastShoeDocument) async {
    return await getShoes(lastBrandDocument: lastBrandDocument, lastShoeDocument: lastShoeDocument);
  }
}

class ShoesResult {
  final List<Shoe> shoes;
  final DocumentSnapshot? lastBrandDocument;
  final DocumentSnapshot? lastShoeDocument;

  ShoesResult(this.shoes, this.lastBrandDocument, this.lastShoeDocument);
}
