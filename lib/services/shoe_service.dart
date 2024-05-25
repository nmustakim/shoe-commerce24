import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/shoe.dart';

class ShoesService {
  final CollectionReference _brandsCollection;

  ShoesService(FirebaseFirestore firestore)
      : _brandsCollection = firestore.collection('brands');

  Future<void> deleteShoe(String brandId, String shoeId) async {
    try {
      await _brandsCollection
          .doc(brandId)
          .collection('shoes')
          .doc(shoeId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting shoe: $e');
      rethrow;
    }
  }

  Future<ShoesResult> getShoes({DocumentSnapshot? lastBrandDocument,
    DocumentSnapshot? lastShoeDocument}) async {
    List<Shoe> shoes = [];
    QuerySnapshot brandSnapshot;

    if (lastBrandDocument == null) {
      brandSnapshot = await _brandsCollection.limit(1).get();
    } else {
      brandSnapshot = await _brandsCollection
          .startAfterDocument(lastBrandDocument)
          .limit(1)
          .get();
    }

    if (brandSnapshot.docs.isEmpty) {
      return ShoesResult([], null, null);
    }

    DocumentSnapshot brandDoc = brandSnapshot.docs.first;
    QuerySnapshot shoeSnapshot;

    if (lastShoeDocument == null) {
      shoeSnapshot =
      await brandDoc.reference.collection('shoes').limit(6).get();
    } else {
      shoeSnapshot = await brandDoc.reference
          .collection('shoes')
          .startAfterDocument(lastShoeDocument)
          .limit(6)
          .get();
    }

    shoes.addAll(
        shoeSnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());

    DocumentSnapshot? newLastBrandDocument = brandDoc;
    DocumentSnapshot? newLastShoeDocument =
    shoeSnapshot.docs.isNotEmpty ? shoeSnapshot.docs.last : null;

    while (shoes.length < 6 && newLastBrandDocument != null) {
      QuerySnapshot nextBrandSnapshot = await _brandsCollection
          .startAfterDocument(newLastBrandDocument)
          .limit(1)
          .get();
      if (nextBrandSnapshot.docs.isNotEmpty) {
        newLastBrandDocument = nextBrandSnapshot.docs.first;
        newLastShoeDocument = null;
        shoeSnapshot = await newLastBrandDocument.reference
            .collection('shoes')
            .limit(6 - shoes.length)
            .get();
        shoes.addAll(
            shoeSnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());
        newLastShoeDocument =
        shoeSnapshot.docs.isNotEmpty ? shoeSnapshot.docs.last : null;
      } else {
        newLastBrandDocument = null;
      }
    }

    return ShoesResult(shoes, newLastBrandDocument, newLastShoeDocument);
  }

  Future<ShoesResult> getMoreShoes(DocumentSnapshot lastBrandDocument,
      DocumentSnapshot lastShoeDocument) async {
    return await getShoes(
        lastBrandDocument: lastBrandDocument,
        lastShoeDocument: lastShoeDocument);
  }

  Future<ShoesResult> getBrandShoes(String brandId,
      {DocumentSnapshot? lastShoeDocument}) async {
    List<Shoe> shoes = [];
    QuerySnapshot shoeSnapshot;

    if (lastShoeDocument == null) {
      shoeSnapshot = await _brandsCollection
          .doc(brandId)
          .collection('shoes')
          .limit(6)
          .get();
    } else {
      shoeSnapshot = await _brandsCollection
          .doc(brandId)
          .collection('shoes')
          .startAfterDocument(lastShoeDocument)
          .limit(6)
          .get();
    }

    shoes.addAll(
        shoeSnapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());

    DocumentSnapshot? newLastShoeDocument =
    shoeSnapshot.docs.isNotEmpty ? shoeSnapshot.docs.last : null;

    return ShoesResult(shoes, null, newLastShoeDocument);
  }

  Future<ShoesResult> getMoreBrandShoes(String brandId,
      DocumentSnapshot lastShoeDocument) async {
    return await getBrandShoes(brandId, lastShoeDocument: lastShoeDocument);
  }

  Future<ShoesResult> getShoesByFilter({
    String? brand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    List<String>? colors,
    DocumentSnapshot? lastShoeDocument,
  }) async {
    List<Shoe> shoes = [];

    // Fetch all brand documents
    QuerySnapshot brandSnapshot = await _brandsCollection.get();

    // Execute queries for each brand's shoes collection
    for (var brandDoc in brandSnapshot.docs) {
      Query query = brandDoc.reference.collection('shoes');

      if (gender != null && gender.isNotEmpty) {
        query = query.where('gender', isEqualTo: gender);
      }

      if (colors != null && colors.isNotEmpty) {
        query = query.where('colors', arrayContainsAny: colors);
      }

      if (minPrice != null) {
        query = query.where('price', isGreaterThanOrEqualTo: minPrice);
      }
      if (brand != 'All') {
        query = query.where('brand', isEqualTo: brand);
      }

      if (maxPrice != null) {
        query = query.where('price', isLessThanOrEqualTo: maxPrice);
      }

      if (lastShoeDocument != null) {
        query = query.startAfterDocument(lastShoeDocument);
      }

      query = query.limit(10);

      final snapshot = await query.get();
      shoes.addAll(snapshot.docs.map((doc) => Shoe.fromDocument(doc)).toList());
    }

    if (sortBy != null) {
      if (sortBy == 'Most recent') {
        shoes.sort((a, b) => b.date.compareTo(a.date));
      } else if (sortBy == 'Lowest price') {
        shoes.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'Highest review') {
        shoes.sort((a, b) => b.averageRating.compareTo(a.averageRating));
      }
    }

    // Get the last shoe document for pagination
    DocumentSnapshot? newLastShoeDocument = shoes.isNotEmpty
        ? await _brandsCollection
        .doc(shoes.last.brand)
        .collection('shoes')
        .doc(shoes.last.id)
        .get()
        : null;

    return ShoesResult(shoes, null, newLastShoeDocument);
  }

}
class ShoesResult {
  final List<Shoe> shoes;
  final DocumentSnapshot? lastBrandDocument;
  final DocumentSnapshot? lastShoeDocument;

  ShoesResult(this.shoes, this.lastBrandDocument, this.lastShoeDocument);
}
