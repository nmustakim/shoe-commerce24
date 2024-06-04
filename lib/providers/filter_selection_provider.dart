import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  double? minPrice =200;
  double? maxPrice=700;
  String selectedBrand = '';
  String sortBy = '';
  String gender = '';
  List<String> colors = [];

  List<String> categories = ["All", "Nike", "Puma", "Adidas", "Reebok"];

  void updateFilters({
    double? minPrice,
    double? maxPrice,
    String? selectedBrand,
    String? sortBy,
    String? gender,
    List<String>? colors,
  }) {
    if (minPrice != null) updateMinPrice(minPrice);
    if (maxPrice != null) updateMaxPrice(maxPrice);
    if (selectedBrand != null) selectBrand(selectedBrand);
    if (sortBy != null) selectSortBy(sortBy);
    if (gender != null) selectGender(gender);
    if (colors != null) selectColor(colors);
  }

  void updateMinPrice(double value) {
    minPrice = value;
    notifyListeners();
  }

  void updateMaxPrice(double value) {
    maxPrice = value;
    notifyListeners();
  }

  void selectBrand(String brand) {
    selectedBrand = brand;
    notifyListeners();
  }

  void selectSortBy(String sortOption) {
    sortBy = sortOption;
    notifyListeners();
  }

  void selectGender(String selectedGender) {
    gender = selectedGender;
    notifyListeners();
  }

  void selectColor(List<String> selectedColors) {
    colors = selectedColors;
    notifyListeners();
  }

  int calculateFilterCount() {
    int count = 0;
    if (minPrice != 0 || maxPrice != 0) count++;
    if (selectedBrand.isNotEmpty) count++;
    if (sortBy.isNotEmpty) count++;
    if (gender.isNotEmpty) count++;
    count += colors.length;
    return count;
  }

  void resetFilters() {
    minPrice = 100;
    maxPrice = 700;
    selectedBrand = '';
    sortBy = '';
    gender = '';
    colors = [];
    notifyListeners();
  }
}
