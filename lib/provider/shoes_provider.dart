import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  DocumentSnapshot? _lastDocument;

  ShoesProvider(this._shoesService) {
    fetchShoes();
  }

  List<Shoe> get shoes => _shoes;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get selectedIndex => _selectedIndex;

  Future<void> fetchShoes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _shoesService.getShoes();
      _shoes = result.shoes;
      _lastDocument = result.lastDocument;
    } catch (e) {
      _error = 'Error fetching shoes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreShoes() async {
    if (_isFetchingMore || _lastDocument == null) return;
    _isFetchingMore = true;
    notifyListeners();

    try {
      final result = await _shoesService.getMoreShoes(_lastDocument!);
      _shoes.addAll(result.shoes);
      _lastDocument = result.lastDocument;

    } catch (e) {
      _error = 'Error fetching more shoes: $e';
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
