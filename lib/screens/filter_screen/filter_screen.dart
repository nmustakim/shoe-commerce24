import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/global_widgets/k_appbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/providers/shoes_provider.dart';

import '../../const/color.dart';
import '../../const/img_asset.dart';
import '../../const/text_style.dart';
import '../../helper/navigation_helper.dart';
import '../../providers/filter_selection_provider.dart';

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
    FilterProvider filterProvider =
        Provider.of<FilterProvider>(context, listen: false);

    _minPrice = filterProvider.minPrice??0;
    _maxPrice = filterProvider.maxPrice??0;
    _selectedBrand = widget.selectedBrand ;
    _sortBy = filterProvider.sortBy;
    _gender = filterProvider.gender;
    _colors = List<String>.from(filterProvider.colors);
  }

  void _resetFilters() {
    Provider.of<FilterProvider>(context, listen: false).resetFilters();
    setState(() {
      _minPrice = 0;
      _maxPrice = 0;
      _selectedBrand = '';
      _sortBy = '';
      _gender = '';
      _colors = [];
    });
  }

  double _minPrice = 0;
  double _maxPrice = 0;
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
            _buildPriceSlider(),
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

  Widget _buildPriceSlider() {
    return Stack(
      children: [
        FlutterSlider(
          tooltip: FlutterSliderTooltip(
              format: (String value) {
                final doubleValue = double.tryParse(value) ?? 0;
                return '\$${doubleValue.toInt()}';
              },
              boxStyle: const FlutterSliderTooltipBox(
                  foregroundDecoration:
                      BoxDecoration(color: Colors.transparent)),
              alwaysShowTooltip: true,
              textStyle: bodyTextW700F12Dark,
              positionOffset: FlutterSliderTooltipPositionOffset(top: 45.h)),
          trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(color: buttonBackground),
            inactiveTrackBar: BoxDecoration(color: secondaryBackgroundWhite3),
          ),
          values: [_minPrice, _maxPrice],
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
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: SvgPicture.asset(ImageAsset.thumb),
          ),
          rightHandler: FlutterSliderHandler(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: SvgPicture.asset(ImageAsset.thumb),
          ),
        ),
        Positioned(
          left: 8.w,
          right: 0,
          top: 52.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$0',
                style: bodyTextW700F12Light,
              ),
              Text(
                '\$1750',
                style: bodyTextW700F12Light,
              )
            ],
          ),
        ),
      ],
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
            _resetFilters();


          },
          height: 50.h,
          width: 150.w,
        ),
        KButton(
          text: 'APPLY',
          onPressed: () {

            Provider.of<FilterProvider>(context, listen: false).updateFilters(
              minPrice: _minPrice==0?null:_minPrice,
              maxPrice: _maxPrice==0?null:_maxPrice,
              selectedBrand: _selectedBrand,
              sortBy: _sortBy,
              gender: _gender,
              colors: _colors,
            );
            var shoesProvider =
                Provider.of<ShoesProvider>(context, listen: false);
            shoesProvider.setSelectedBrand(
                shoesProvider.categories.indexOf(_selectedBrand), false);
            shoesProvider.fetchShoesByFilter(
              brand: _selectedBrand,
              minPrice: _minPrice==0?null:_minPrice,
              maxPrice: _maxPrice==0?null:_maxPrice,
              sortBy: _sortBy,
              gender: _gender,
              colors: _colors,
            );
            print(_sortBy);
            NavigationHelper.navigateToDiscoverShoes(context);
          },
          height: 50.h,
          width: 150.h,
        ),
      ],
    );
  }

  List<Widget> _buildBrandButtons() {
    List<String> brands = ['Nike', 'Puma', 'Adidas', 'Reebok'];
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
                      shape: BoxShape.circle, color: secondaryBackgroundWhite3),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/$brand.svg',
                    ),
                  ),
                ),
                if (_selectedBrand == brand)
                  Positioned(
                      bottom: 0,
                      right: 0,
                      top: 28.h,
                      child: SvgPicture.asset(ImageAsset.checkCircle))
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
    List<String> sortOptions = [
      'Most recent',
      'Lowest price',
      'Highest review'
    ];
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
    List<String> colors = ['Black', 'Grey', 'Red'];
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
                        : secondaryBackgroundWhite1)),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 8.r,
               backgroundColor: color == 'Black'
                ? Colors.black
                    : color == 'Grey'
                ? Colors.grey
                    : color == 'Red'
                ? Colors.red
                    : Colors.green,

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
    if (_minPrice != 0 || _maxPrice != 0) count++;
    if (_selectedBrand.isNotEmpty && _selectedBrand !=  "All") count++;
    if (_sortBy.isNotEmpty) count++;
    if (_gender.isNotEmpty) count++;
    count += _colors.length;
    return count;
  }
}
