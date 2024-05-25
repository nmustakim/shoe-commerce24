import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/img_asset.dart';
import 'package:shoe_commerce/global_widgets/k_bottom_bar.dart';
import 'package:shoe_commerce/global_widgets/k_appbar.dart';
import 'package:shoe_commerce/global_widgets/k_remove_button.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/models/cart_item.dart';
import 'package:shoe_commerce/screens/product_details/widgets/rating_stars.dart';
import 'package:shoe_commerce/screens/reviews/widget/review_shimmer.dart';
import 'package:shoe_commerce/screens/reviews/widget/review_widget.dart';
import 'package:shoe_commerce/util/color_util.dart';
import 'package:shoe_commerce/util/string_util.dart';
import '../../const/text_style.dart';
import '../../global_widgets/k_add_button.dart';
import '../../helper/navigation_helper.dart';
import '../../models/shoe.dart';
import '../../providers/cart_provider.dart';
import '../../providers/review_provider.dart';
import '../../services/navigation_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailsScreen({super.key, required this.shoe});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _currentPageIndex = 0;

  final PageController _pageController = PageController();
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
          hasTrailing: true,
          onTrailingTap: () => NavigationHelper.navigateToCartScreen(context)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(widget.shoe),
              _verticalSpacing(20),
              _buildProductDetails(widget.shoe),
              _verticalSpacing(20),
              _buildSizeSelection(widget.shoe.sizes),
              _verticalSpacing(20),
              _buildDescription(),
              _verticalSpacing(20),
              _buildTopReviews(widget.shoe),
              _buildAllReviewButton(),
              _verticalSpacing(24)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: primary,
          child: KBottomBar(
              labelText: 'Price',
              valueText: '\$${widget.shoe.price.toStringAsFixed(2)}',
              buttonText: 'ADD TO CART',
              onButtonPressed: () => _showAddToCartPopup(context))),
    );
  }

  Widget _buildImageSlider(Shoe shoe) {
    return Stack(
      children: [
        Container(
          height: 315.h,
          decoration: BoxDecoration(
              color: secondaryBackgroundWhite1,
              borderRadius: BorderRadius.circular(20.r)),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemCount: shoe.images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                placeholder: (context, url) =>
                const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error,size: 10.sp,),
                imageUrl:
                shoe.images[index],
                width: 252.w,
                fit: BoxFit.fitWidth,
              );
            },
          ),
        ),
        Positioned(
          left: 20.w,
          bottom: 20.h,
          child: Row(
            children: List.generate(shoe.images.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _buildDot(index == _currentPageIndex
                    ? buttonBackground
                    : secondaryBackgroundWhite2),
              );
            }),
          ),
        ),
        Positioned(
          right: 8.w,
          bottom: 8.h,
          child: _buildColorSelection(widget.shoe.colors),
        ),
      ],
    );
  }

  Widget _buildProductDetails(Shoe shoe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(shoe.name, style: bodyTextW700F20Dark),
        _verticalSpacing(10),
        Row(
          children: [
            RatingStars(rating: shoe.averageRating),
            _horizontalSpacing(5),
            Text(shoe.averageRating.toString(), style: bodyTextW700F11Dark),
            _horizontalSpacing(5),
            Text(
              '(${shoe.reviewCount} Reviews)',
              style: bodyTextW400F11Light,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorSelection(List<String> colors) {
    return Container(
      height: 40.h,
      width: 132.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(colors.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColorIndex = index;
              });
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtil.getColorFromString(colors[index]),
                  ),
                  width: 20.w,
                  height: 20.h,
                ),
                if (_selectedColorIndex == index)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: SvgPicture.asset(
                      ImageAsset.check,
                      height: 2.4.h,
                      width: 9.04.w,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      height: 7.h,
      width: 7.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildSizeSelection(List<double> sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: headlineW600F16),
        _verticalSpacing(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(sizes.length, (index) {
            bool isSelected = _selectedSizeIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSizeIndex = index;
                });
              },
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: isSelected ? buttonBackground : primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? buttonBackground : borderLight,
                  ),
                ),
                child: Center(
                  child: Text(StringUtil.formatSize(sizes[index], index),
                      style: bodyTextW700F14Light.copyWith(
                          color: isSelected ? primary : buttonBackground)),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: headlineW600F16.copyWith(height: 1.71)),
        _verticalSpacing(10),
        Wrap(
          children: [
            Text(
              widget.shoe.description,
              style: bodyTextW400F14Light,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopReviews(Shoe shoe) {
    return Consumer<ReviewProvider>(
      builder: (context, reviewProvider, child) {
        if (reviewProvider.isFetchingTop) {
          return const ReviewShimmerLoadingList(itemCount: 3);
        }

        if (reviewProvider.topReviews.isEmpty) {
          return Text('No reviews yet.', style: bodyTextW400F14Light);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Review (${reviewProvider.topReviews.length})',
                style: headlineW600F16),
            _verticalSpacing(10),
            ...reviewProvider.topReviews.map((review) {
              return buildReviewItem(review);
            }),
          ],
        );
      },
    );
  }

  Widget _buildAllReviewButton() {
    return SizedBox(
      width: double.infinity,
      child: Consumer<ReviewProvider>(builder: (_, reviewProvider, child) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: reviewProvider.isLoading
                ? secondaryBackgroundWhite2
                : buttonBackground,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: secondaryBackgroundWhite1),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          onPressed: reviewProvider.isLoading
              ? () {}
              : () async {
                  await reviewProvider.fetchReviews(widget.shoe.id).then(
                        (value) => NavigationHelper.navigateToReviewScreen(
                            context, widget.shoe),
                      );
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (reviewProvider.isLoading)
                Container(
                    margin: EdgeInsets.only(right: 24.w),
                    child: const CupertinoActivityIndicator()),
              Text(
                reviewProvider.isLoading ? 'Loading...' : 'SEE ALL REVIEW',
                style: bodyTextW700F14Dark,
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showAddToCartPopup(BuildContext context) {
    int selectedQuantity = 1;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add to Cart', style: bodyTextW700F20Dark),
                      IconButton(
                          onPressed: () =>NavigationService.popNavigate(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  _verticalSpacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Quantity',
                              style: bodyTextW700F14Dark,
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                            height: 40.h,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                    text: selectedQuantity.toString()),
                                onChanged: (value) {
                                  if (int.tryParse(value) != null) {
                                    selectedQuantity = int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KRemoveButton(onRemove: () {
                            if (selectedQuantity > 1) {
                              selectedQuantity--;
                              (context as Element).markNeedsBuild();
                            }
                          }),
                          _horizontalSpacing(16.w),
                          KAddButton(
                            onAdd: () {
                              selectedQuantity++;
                              (context as Element).markNeedsBuild();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _verticalSpacing(24),
                  KBottomBar(
                      labelText: 'Total Price',
                      valueText:
                          '\$${(widget.shoe.price * selectedQuantity).toStringAsFixed(2)}',
                      buttonText: 'ADD TO CART',
                      onButtonPressed: () {
                        final shoe = widget.shoe;
                        cartProvider.addToCart(CartItemModel(
                            image: shoe.images.first,
                            size: StringUtil.formatSize(
                                shoe.sizes[_selectedSizeIndex],
                                _selectedSizeIndex),
                            name: shoe.name,
                            brand: shoe.brand,
                            color: StringUtil.capitalizeFirstLetter(
                                shoe.colors[_selectedColorIndex]),
                            price: shoe.price,
                            quantity: selectedQuantity));
                        NavigationService.popNavigate();
                        _showAddedToCartPopup(context, selectedQuantity);
                      })
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showAddedToCartPopup(BuildContext context, int quantity) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAsset.tickCircle),
                  _verticalSpacing(24),
                  Text(
                    'Added to cart',
                    style: headlineW600F24,
                  ),
                  Text(
                    '$quantity Item(s) total',
                    style: bodyTextW400F12Light,
                  ),
                  _verticalSpacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KButton(
                        text: 'BACK EXPLORE',
                        onPressed: () =>
                            NavigationHelper.navigateToDiscoverShoes(context),
                        foregroundColor: buttonBackground,
                        backgroundColor: primary,
                        height: 52.h,
                        width: 156.w,
                      ),
                      KButton(
                        text: 'TO CART',
                        onPressed: () {
                          NavigationService.popNavigate();

                          NavigationHelper.navigateToCartScreen(context);
                        },
                        height: 52.h,
                        width: 156.w,
                      )
                    ],
                  )
                ]));
      },
    );
  }

  Widget _horizontalSpacing(double width) {
    return SizedBox(width: width.w);
  }

  Widget _verticalSpacing(double height) {
    return SizedBox(height: height.h);
  }
}
