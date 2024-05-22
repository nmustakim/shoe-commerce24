import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/screens/cart/cart_screen.dart';
import 'package:shoe_commerce/screens/discover_shoes/widgets/shoe_card.dart';
import 'package:shoe_commerce/screens/filter_screen.dart';
import 'package:shoe_commerce/screens/product_details/priduct_details_screen.dart';
import '../../model/shoe.dart';
import '../../provider/shoes_provider.dart';

class DiscoverShoes extends StatefulWidget {
  const DiscoverShoes({super.key});

  @override
  DiscoverShoesState createState() => DiscoverShoesState();
}

class DiscoverShoesState extends State<DiscoverShoes> {
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
      appBar: KAppBar(
          isDiscoverScreen: true,
          hasTitle: true,
          title: 'Discover',
          hasTrailing: true,
          onTrailingTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShoppingCartScreen()))),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
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
                            style: headlineW600F20.copyWith(
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
                    childAspectRatio: 0.7111111111,
                  ),
                  itemCount: shoesProvider.shoes.length,
                  itemBuilder: (context, index) {
                    final Shoe shoe = shoesProvider.shoes[index];
                    return ShoeCard(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsScreen(shoe: shoe))),
                      shoe: shoesProvider.shoes[index],
                    );
                  },
                ),
              ),
              if (shoesProvider.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FilterScreen())),
        child: Container(
           height: 40.h,
          width: 119.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: buttonBackground,
          ),
          child: Center(
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
      ),
    );
  }
}
