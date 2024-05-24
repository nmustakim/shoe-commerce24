import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/shoe.dart';
import '../services/shoe_service.dart';

class ShoesProvider extends ChangeNotifier {
  final ShoesService _shoesService;
  List<Shoe> _shoes = [];
  List<String> categories = ["All", "Nike", "Puma", "Adidas", "Reebok"];
  String _selectedBrand = "All";
  bool _isLoading = false;

  String? _error;
  int _selectedBrandIndex = 0;
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
  int get selectedIndex => _selectedBrandIndex;
  String get selectedBrand => _selectedBrand;
  final Map<String, List<Shoe>> _shoesCache = {};
  // Future<void> fetchShoes() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();
  //
  //   try {
  //     final category = categories[_selectedBrandIndex];
  //     final result = category == "All"
  //         ? await _shoesService.getShoes()
  //         : await _shoesService.getBrandShoes(category);
  //     _shoes = result.shoes;
  //     _lastBrandDocument = result.lastBrandDocument;
  //     _lastShoeDocument = result.lastShoeDocument;
  //   } catch (e) {
  //     _error = 'Error fetching shoes: $e';
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchShoes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final category = categories[_selectedBrandIndex];
      if (_shoesCache.containsKey(category)) {
        // Use cached data if available
        _shoes = _shoesCache[category]!;
      } else {
        // Fetch data if not available in cache
        final result = category == "All"
            ? await _shoesService.getShoes()
            : await _shoesService.getBrandShoes(category);
        _shoes = result.shoes;
        _lastBrandDocument = result.lastBrandDocument;
        _lastShoeDocument = result.lastShoeDocument;
        // Cache fetched shoes
        _shoesCache[category] = _shoes;
      }
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
      final category = categories[_selectedBrandIndex];
      final result = category == "All"
          ? await _shoesService.getMoreShoes(
              _lastBrandDocument!, _lastShoeDocument!)
          : await _shoesService.getMoreBrandShoes(
              category, _lastBrandDocument!);
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

  Future<void> fetchShoesByFilter(
      {String? brand,
      double? minPrice,
      double? maxPrice,
      String? sortBy,
      String? gender,
      List<String>? colors}) async {
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

  void setSelectedBrand(int index, bool isFromDiscover) {
    if(index == -1) {
      _selectedBrandIndex = 0;
      _selectedBrand = categories[0];
    }
    else{
      _selectedBrandIndex = index;
      _selectedBrand = categories[index];

      if (isFromDiscover) {
        fetchShoes();
      }
    }

    notifyListeners();
  }
}
