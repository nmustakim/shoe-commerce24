import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';

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
  String _selectedBrand = 'Nike';
  String _sortBy = 'Most recent';
  String _gender = 'Man';
  List<String> _colors = ['Black'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        hasTrailing: true,
          title: 'Filter',
          hasTitle: true,
          onTap: (){}),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            Text('Brands', style: headline600small),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildBrandButtons(),
            ),
            SizedBox(height: 20.h),
            Text('Price Range', style: headline600small),
            RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              min: 0,
              max: 1750,
              divisions: 35,
              labels: RangeLabels('\$${_minPrice.round()}', '\$${_maxPrice.round()}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            SizedBox(height: 20.h),
            Text('Sort By', style: headline600small),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSortButtons(),
            ),
            SizedBox(height: 20.h),
            Text('Gender', style: headline600small),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildGenderButtons(),
            ),
            SizedBox(height: 20.h),
            Text('Color', style: headline600small),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildColorButtons(),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Reset filters
                    setState(() {
                      _minPrice = 200;
                      _maxPrice = 750;
                      _selectedBrand = 'Nike';
                      _sortBy = 'Most recent';
                      _gender = 'Man';
                      _colors = ['Black'];
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: buttonBackground),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('RESET (4)', style: bodyText700Big.copyWith(color: buttonBackground)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filters
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('APPLY', style: buttonTextStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBrandButtons() {
    List<String> brands = [''
        'Nike', 'Puma', 'Adidas', 'Reebok'];
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
                    shape: BoxShape.circle,
                   color:secondaryBackground3
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/$brand.png',


                    ),
                  ),
                ),
                if(_selectedBrand==brand)
                Positioned(
                  bottom: 0,
                    right: 0,
                    child: Image.asset('assets/images/tick-circle.png'))
              ],
            ),
            SizedBox(height: 8.h,),
            Text(brand,style: bodyText700Small,),
            Text('500 Items',style: bodyText400LightSmall,)
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildSortButtons() {
    List<String> sortOptions = ['Most recent', 'Lowest price', 'Highest price'];
    return sortOptions.map((option) {
      return ChoiceChip(
        label: Text(option, style: bodyText400Dark),
        selected: _sortBy == option,
        onSelected: (bool selected) {
          setState(() {
            _sortBy = option;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildGenderButtons() {
    List<String> genders = ['Man', 'Woman', 'Unisex'];
    return genders.map((gender) {
      return ChoiceChip(
        label: Text(gender, style: bodyText400Dark),
        selected: _gender == gender,
        onSelected: (bool selected) {
          setState(() {
            _gender = gender;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildColorButtons() {
    List<String> colors = ['Black', 'White', 'Red'];
    return colors.map((color) {
      return ChoiceChip(
        label: Text(color, style: bodyText400Dark),
        selected: _colors.contains(color),
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
    }).toList();
  }
}