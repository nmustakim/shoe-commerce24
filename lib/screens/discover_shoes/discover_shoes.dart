import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/img_asset.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/k_appbar.dart';
import 'package:shoe_commerce/routes.dart';
import 'package:shoe_commerce/screens/discover_shoes/shimmer_card.dart';
import 'package:shoe_commerce/screens/discover_shoes/widgets/shoe_card.dart';
import '../../helper/navigation_helper.dart';
import '../../models/shoe.dart';
import '../../providers/review_provider.dart';
import '../../providers/shoes_provider.dart';
import '../../services/navigation_service.dart';

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
    final shoesProvider = Provider.of<ShoesProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      appBar: KAppBar(

        isDiscoverScreen: true,
        hasTitle: true,
        title: 'Discover',
        hasTrailing: true,
        onTrailingTap: () => NavigationHelper.navigateToCartScreen(context),
      ),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _verticalSpacing(16),
              _buildCategoryRow(shoesProvider),
              _verticalSpacing(16),
              Expanded(
                child: shoesProvider.isLoading
                    ? _buildShimmerGrid(8)
                    : shoesProvider.shoes.isEmpty
                        ? Center(
                            child: Text(
                              'No shoes found!',
                              style: headlineW700F30,
                            ),
                          )
                        : GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                   mainAxisSpacing: 16.h,
                                    crossAxisCount: 2, childAspectRatio: 0.66,
                                  crossAxisSpacing: 8.w


                                ),
                            itemCount: shoesProvider.shoes.length,
                            itemBuilder: (context, index) {
                              final Shoe shoe = shoesProvider.shoes[index];
                              return ShoeCard(
                                onTap: () {
                                  Provider.of<ReviewProvider>(context,
                                          listen: false)
                                      .fetchTop3Reviews(shoe.id);
                                  NavigationHelper.navigateToProductDetails(
                                      context, shoe);
                                },
                                shoe: shoesProvider.shoes[index],
                              );
                            },
                          ),
              ),
              if (shoesProvider.isFetchingMore)
                const Center(child: CupertinoActivityIndicator())
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context, shoesProvider),
    );
  }

  Widget _buildCategoryRow(ShoesProvider shoesProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: shoesProvider.categories.map<Widget>((category) {
          int index = shoesProvider.categories.indexOf(category);
          bool isSelected = index == shoesProvider.selectedIndex;
          return GestureDetector(
            onTap: () {
              shoesProvider.fetchShoesByFilter(brand: category);
              shoesProvider.setSelectedBrand(index, true);
            },
            child: Row(
              children: [
                if (index > 0) _horizontalSpacing(16),
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
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, ShoesProvider shoesProvider) {
    return InkWell(
      onTap: () => NavigationService.navigateToNamedRoute(
        AppRoutes.filterScreen,
        arguments: {'selectedBrand': shoesProvider.selectedBrand},
      ),
      child: SvgPicture.asset(
        ImageAsset.filterIcon,
      ),
    );
  }

  Widget _buildShimmerGrid(int itemCount) {
    return GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.h,
          crossAxisCount: 2, childAspectRatio: 0.66,),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ShoeCardShimmer();
      },
    );
  }

  Widget _verticalSpacing(double height) {
    return SizedBox(height: height.h);
  }

  Widget _horizontalSpacing(double width) {
    return SizedBox(width: width.w);
  }
}
