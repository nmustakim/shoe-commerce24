import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/shoe.dart';
import '../services/shoe_service.dart';

class ShoesProvider extends ChangeNotifier {

  final ShoesService _shoesService;
  List<Shoe> _shoes = [];
  List<String> categories = ["All", "Nike", "Jordan", "Adidas", "Reebok"];
  bool _isLoading = false;

  String? _error;
  int _selectedIndex = 0;
  bool _isFetchingMore = false;
  DocumentSnapshot? _lastBrandDocument;
  DocumentSnapshot? _lastShoeDocument;
  DocumentSnapshot? _lastFilteredShoeDocument;


  ShoesProvider(this._shoesService) {
    fetchShoes();
  }

  List<Shoe> get shoes => _shoes;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;

  String? get error => _error;
  int get selectedIndex => _selectedIndex;

  Future<void> fetchShoes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final category = categories[_selectedIndex];
      final result = category == "All"
          ? await _shoesService.getShoes()
          : await _shoesService.getBrandShoes(category);
      _shoes = result.shoes;
      _lastBrandDocument = result.lastBrandDocument;
      _lastShoeDocument = result.lastShoeDocument;
    } catch (e) {
      _error = 'Error fetching shoes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreShoes() async {
    if (_isFetchingMore || _lastBrandDocument == null) return;
    _isFetchingMore = true;
    notifyListeners();

    try {
      final category = categories[_selectedIndex];
      final result = category == "All"
          ? await _shoesService.getMoreShoes(_lastBrandDocument!, _lastShoeDocument!)
          : await _shoesService.getMoreBrandShoes(category, _lastBrandDocument!);
      _shoes.addAll(result.shoes);
      _lastBrandDocument = result.lastBrandDocument;
      _lastShoeDocument = result.lastShoeDocument;
    } catch (e) {
      _error = 'Error fetching more shoes: $e';
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchShoesByFilter({
    String? brand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? gender,
    List<String>? colors
  }) async {
    _lastFilteredShoeDocument = null;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _shoesService.getShoesByFilter(
        brand: brand,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
        gender: gender,
        colors: colors,
        lastShoeDocument: _lastFilteredShoeDocument,
      );
      _shoes = result.shoes;
      _lastFilteredShoeDocument = result.lastShoeDocument;

    } catch (e) {
      _error = 'Error fetching shoes by filter: $e';
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }


  void setSelectedIndex(int index) {
    _selectedIndex = index;
    fetchShoes();
    notifyListeners();
  }

}
