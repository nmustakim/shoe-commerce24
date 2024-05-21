import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';

import '../const/color.dart';
import '../const/text_style.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  double _minPrice = 200;
  double _maxPrice = 750;
  String _selectedBrand = '';
  String _sortBy = '';
  String _gender = '';
  List<String> _colors = [''];

  @override
  Widget build(BuildContext context) {
    int filterCount = calculateFilterCount();

    return Scaffold(
      appBar: KAppBar(
          hasTrailing: true, title: 'Filter', hasTitle: true, onTrailingTap: () {}),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            Text('Brands', style: headline600small),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildBrandButtons(),
            ),
            SizedBox(height: 34.h),
            Text('Price Range', style: headline600small),
            SizedBox(height: 20.h),
            RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              min: 0,
              max: 1750,
              divisions: 35,
              labels: RangeLabels(
                  '\$${_minPrice.round()}', '\$${_maxPrice.round()}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            SizedBox(height: 34.h),
            Text('Sort By', style: headline600small),
            SizedBox(height: 20.h),
            _buildSortButtons(),
            SizedBox(height: 34.h),
            Text('Gender', style: headline600small),
            SizedBox(height: 20.h),
            _buildGenderButtons(),
            SizedBox(height: 34.h),
            Text('Color', style: headline600small),
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
      color: buttonForeground,
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
            backgroundColor: buttonForeground,
            foregroundColor: buttonBackground,
            onPressed: () {
              setState(() {
                _minPrice = 200;
                _maxPrice = 750;
                _selectedBrand = '';
                _sortBy = '';
                _gender = '';
                _colors = [''];
              });
            },
            height: 50.h,
            width: 150.w),
        KButton(text: 'APPLY', onPressed: () {}, height: 50.h, width: 150.h)
      ],
    );
  }

  List<Widget> _buildBrandButtons() {
    List<String> brands = [
      ''
          'Nike',
      'Puma',
      'Adidas',
      'Reebok'
    ];
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
                      child: Image.asset('assets/images/tick-circle.png'))
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              brand,
              style: bodyText700Small,
            ),
            Text(
              '500 Items',
              style: bodyText400LightSmall,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(140.r)),
          selectedColor: buttonBackground,
          label: Text(option,
              style:  headline600small.copyWith(
                  color:
                      _sortBy == option ? buttonForeground : buttonBackground)),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(140.r)),
        selectedColor: buttonBackground,
        label: Text(gender,
            style:  headline600small.copyWith(
                color:
                    _gender == gender ? buttonForeground : buttonBackground)),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r),side: BorderSide(color:_colors.contains(color)?buttonBackground:secondaryBackground1 )),
        label: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            CircleAvatar(radius: 8.r,backgroundColor: color=='Black'?Colors.black:color=='White'?Colors.white:Colors.red,),
            SizedBox(width: 8.w,),
            Text(color,
                style: headline600small),
          ],
        ),

        selected: _colors.contains(color),
        selectedColor: buttonForeground,

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
    count += _colors.length - 1; // Subtract 1 to exclude the empty string in _colors
    return count;
  }
}
