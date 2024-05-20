
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/screens/discover_shoes/widgets/shoe_card.dart';
import '../../provider/shoes_provider.dart';

class DiscoverShoes extends StatefulWidget {
  const DiscoverShoes({super.key});

  @override
  _DiscoverShoesState createState() => _DiscoverShoesState();
}

class _DiscoverShoesState extends State<DiscoverShoes> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<ShoesProvider>(context, listen: false).fetchMoreShoes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Discover', style: headline700),
        actions: [
          Image.asset('assets/images/cart.png'),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: shoesProvider.categories.map<Widget>((category) {
                    int index = shoesProvider.categories.indexOf(category);
                    bool isSelected = index == shoesProvider.selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        shoesProvider.setSelectedIndex(index);
                      },
                      child: Row(
                        children: [
                          if (index > 0) SizedBox(width: 16.w),
                          Text(
                            category,
                            style: headline600.copyWith(
                              color: isSelected ? Colors.black : Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                  ),
                  itemCount: shoesProvider.shoes.length,
                  itemBuilder: (context, index) {
                    return ShoeCard(
                      shoe: shoesProvider.shoes[index],
                    );
                  },
                ),
              ),
              if (shoesProvider.isLoading)
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),      floatingActionButton: InkWell(
      onTap: () {},
      child: Container(
        height: 40.h,
        width: 119.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: buttonBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/filter_icon.png'),
            SizedBox(width: 8.w),
            Text(
              'FILTER',
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
      ),
    );
  }
}




