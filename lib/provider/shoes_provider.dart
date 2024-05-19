import 'package:flutter/foundation.dart';

import '../model/shoe.dart';
import '../services/shoe_service.dart';

class ShoesProvider extends ChangeNotifier {
  final ShoesService _shoesService;
  List<Shoe> _shoes = [];
  List<String> categories = ["All","Nike","Rebook","Adidas"];
  bool _isLoading = false;
  String? _error;

  ShoesProvider(this._shoesService) {
    fetchShoes();
  }

  List<Shoe> get shoes => _shoes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchShoes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _shoes = await _shoesService.getShoes().first;
    } catch (e) {
      _error = 'Error fetching shoes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addShoe(Shoe shoe) async {
    try {
      await _shoesService.addShoe(shoe);
      _shoes.add(shoe);
      notifyListeners(); // Notify listeners after adding a shoe
    } catch (e) {
      debugPrint('Error adding shoe: $e');
      rethrow;
    }
  }

}
