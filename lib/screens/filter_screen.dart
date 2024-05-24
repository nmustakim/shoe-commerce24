import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/global_widgets/k_appbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';

import '../const/color.dart';
import '../const/img_asset.dart';
import '../const/text_style.dart';
import '../providers/shoes_provider.dart';

class FilterScreen extends StatefulWidget {
  final String selectedBrand;

  const FilterScreen({super.key, required this.selectedBrand});


  @override
  FilterScreenState createState() => FilterScreenState();

}


class FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    _selectedBrand = widget.selectedBrand;
  }

  double _minPrice = 200;
  double _maxPrice = 300;
  String _selectedBrand = '';
  String _sortBy = '';
  String _gender = '';
  List<String> _colors = [];

  @override
  Widget build(BuildContext context) {
    int filterCount = calculateFilterCount();

    return Scaffold(
      appBar: KAppBar(
          hasTrailing: true,
          title: 'Filter',
          hasTitle: true,
          onTrailingTap: () {}),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            Text('Brands', style: headlineW600F16),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildBrandButtons(),
            ),
            SizedBox(height: 34.h),
            Text('Price Range', style: headlineW600F16),
            SizedBox(height: 20.h),


            FlutterSlider(
              values: [ _minPrice, _maxPrice ],
              min: 0,
              max: 1750,
              rangeSlider: true,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  _minPrice = lowerValue;
                  _maxPrice = upperValue;
                });
              },

              handler: FlutterSliderHandler(

                decoration: BoxDecoration(),
                child: Material(
                  type: MaterialType.canvas,
                  elevation: 3,
                  child: Container(
                      padding: EdgeInsets.only(bottom:4),
                      child: Image.asset(ImageAsset.thumb)),
                ),

              ),
            ),
            SizedBox(height: 34.h),
            Text('Sort By', style: headlineW600F16),
            SizedBox(height: 20.h),
            _buildSortButtons(),
            SizedBox(height: 34.h),
            Text('Gender', style: headlineW600F16),
            SizedBox(height: 20.h),
            _buildGenderButtons(),
            SizedBox(height: 34.h),
            Text('Color', style: headlineW600F16),
            SizedBox(height: 20.h),
            _buildColorButtons(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(filterCount),
    );
  }

  Widget _buildBottomAppBar(int filterCount) {
    return BottomAppBar(
      color: primary,
      elevation: 1.0,
      child: _buildApplyResetButton(filterCount),
    );
  }

  Widget _buildApplyResetButton(int filterCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KButton(
            text: 'RESET ($filterCount)',
            backgroundColor: primary,
            foregroundColor: buttonBackground,
            onPressed: () {
              setState(() {
                _minPrice = 0;
                _maxPrice = 750;
                _selectedBrand = '';
                _sortBy = '';
                _gender = '';
                _colors = [];
              });
            },
            height: 50.h,
            width: 150.w),
        Consumer<ShoesProvider>(builder: (_, shoesProvider, child) {
          return KButton(
              text: shoesProvider.isLoading ? 'Applying...' : 'APPLY',
              onPressed: shoesProvider.isLoading
                  ? () {}
                  : () {
                      shoesProvider.fetchShoesByFilter(
                        brand: _selectedBrand,
                        minPrice: _minPrice,
                        maxPrice: _maxPrice,
                        sortBy: _sortBy,
                        gender: _gender,
                        colors: _colors,
                      );
                      shoesProvider.setSelectedBrand(
                          shoesProvider.categories.indexOf(_selectedBrand),
                          false);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DiscoverShoes()),
                        );
                      });
                    },
              height: 50.h,
              width: 150.h);
        })
      ],
    );
  }

  List<Widget> _buildBrandButtons() {
    List<String> brands = ['Nike', 'Jordan', 'Adidas', 'Reebok'];
    return brands.map((brand) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedBrand = brand;
          });
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: secondaryBackground3),
                  child: Center(
                    child: Image.asset(
                      'assets/images/$brand.png',
                    ),
                  ),
                ),
                if (_selectedBrand == brand)
                  Positioned(
                      bottom: 0,
                      right: 0,
                      top: 28.h,
                      child: Image.asset('assets/images/check_round.png'))
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              brand,
              style: bodyTextW700F14Dark,
            ),
            Text(
              '500 Items',
              style: bodyTextW400F11Light,
            )
          ],
        ),
      );
    }).toList();
  }

  SingleChildScrollView _buildSortButtons() {
    List<String> sortOptions = ['Most recent', 'Lowest price', 'Highest price'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
          spacing: 12.w,
          children: sortOptions.map((option) {
            return ChoiceChip(
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(140.r)),
              selectedColor: buttonBackground,
              label: Text(option,
                  style: headlineW600F16.copyWith(
                      color: _sortBy == option ? primary : buttonBackground)),
              selected: _sortBy == option,
              onSelected: (bool selected) {
                setState(() {
                  _sortBy = option;
                });
              },
            );
          }).toList()),
    );
  }

  Wrap _buildGenderButtons() {
    List<String> genders = ['Man', 'Woman', 'Unisex'];
    return Wrap(
        spacing: 12.w,
        children: genders.map((gender) {
          return ChoiceChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(140.r)),
            selectedColor: buttonBackground,
            label: Text(gender,
                style: headlineW600F16.copyWith(
                    color: _gender == gender ? primary : buttonBackground)),
            selected: _gender == gender,
            onSelected: (bool selected) {
              setState(() {
                _gender = gender;
              });
            },
          );
        }).toList());
  }

  Wrap _buildColorButtons() {
    List<String> colors = ['Black', 'White', 'Red'];
    return Wrap(
        spacing: 12.w,
        children: colors.map((color) {
          return ChoiceChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
                side: BorderSide(
                    color: _colors.contains(color)
                        ? buttonBackground
                        : secondaryBackground1)),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 8.r,
                  backgroundColor: color == 'Black'
                      ? Colors.black
                      : color == 'White'
                          ? Colors.white
                          : Colors.red,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(color, style: headlineW600F16),
              ],
            ),
            selected: _colors.contains(color),
            selectedColor: primary,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _colors.add(color);
                } else {
                  _colors.remove(color);
                }
              });
            },
          );
        }).toList());
  }

  int calculateFilterCount() {
    int count = 0;
    if (_minPrice != 200 || _maxPrice != 750) count++;
    if (_selectedBrand.isNotEmpty) count++;
    if (_sortBy.isNotEmpty) count++;
    if (_gender.isNotEmpty) count++;
    count +=
        _colors.length - 1; // Subtract 1 to exclude the empty string in _colors
    return count;
  }

}
