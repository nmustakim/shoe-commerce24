import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/global_widgets/k_bottom_bar.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/model/cart_item.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';
import 'package:shoe_commerce/screens/product_details/widgets.dart';
import 'package:shoe_commerce/screens/reviews/review_screen.dart';
import 'package:shoe_commerce/util/color_util.dart';
import 'package:shoe_commerce/util/string_util.dart';
import '../../const/text_style.dart';
import '../../model/shoe.dart';
import '../../provider/cart_provider.dart';
import '../cart/cart_screen.dart';

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
    Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: KAppBar(
          hasTrailing: true,
          onTrailingTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShoppingCartScreen()))),
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
              _buildReviews(widget.shoe),
              _buildAllReviewButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewScreen(
                              shoe: widget.shoe,
                            )));
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: primary,
          child: KBottomBar(
              labelText: 'Price',
              valueText: widget.shoe.price.toStringAsFixed(2),
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
              color: secondaryBackground1,
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
              return Image.network(
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
                    : secondaryBackground2),
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
            Text(
              shoe.averageRating.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            _horizontalSpacing(5),
            Text(
              '(${shoe.reviewCount} Reviews)',
              style: headlineW600F16,
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
                  height: 20.w,
                ),
                if (_selectedColorIndex == index)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/images/check.png',
                      color: primary,
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
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isSelected ? buttonBackground : primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? buttonBackground : borderLight,
                  ),
                ),
                child: Text(StringUtil.formatSize(sizes[index], index),
                    style: bodyTextW700F14Light.copyWith(
                        color: isSelected ? primary : buttonBackground)),
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
        Text('Description', style: headlineW600F16),
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

  Widget _buildReviews(Shoe shoe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews (${shoe.reviews.length})', style: headlineW600F16),
        _verticalSpacing(10),
        ...shoe.reviews.map((review) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const NetworkImage(
                        'https://via.placeholder.com/150'), // Placeholder image
                    radius: 20.r,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.userId,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Row(
                        children: List.generate(review.rating, (index) {
                          return Icon(Icons.star,
                              color: Colors.yellow, size: 16.sp);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              _verticalSpacing(5),
              Text(review.comment, style: TextStyle(fontSize: 14.sp)),
              const Divider(),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildAllReviewButton({required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonBackground,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: secondaryBackground1),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'SEE ALL REVIEW',
          style: bodyTextW700F14Dark,
        ),
      ),
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: secondaryBackground2, size: 24.sp),
                            onPressed: () {
                              if (selectedQuantity > 1) {
                                selectedQuantity--;
                                (context as Element).markNeedsBuild();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, size: 24.sp),
                            onPressed: () {
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
                            color: StringUtil.capitalizeFirstLetter(shoe.colors[_selectedColorIndex]),
                            price: shoe.price,
                            quantity: selectedQuantity));
                        Navigator.pop(context);
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
                  Image.asset('assets/images/tick-circle.png'),
                  _verticalSpacing(24),
                  Text(
                    'Added to cart',
                    style: headlineW600F24,
                  ),
                  Text(
                    '$quantity Item total',
                    style: bodyTextW400F12Light,
                  ),
                  _verticalSpacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KButton(
                        text: 'BACK EXPLORE',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DiscoverShoes()));
                        },
                        foregroundColor: buttonBackground,
                        backgroundColor: primary,
                        height: 52.h,
                        width: 156.w,
                      ),
                      KButton(
                        text: 'TO CART',
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShoppingCartScreen()));
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
