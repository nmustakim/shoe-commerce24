import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/global_widgets/kappbar.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/screens/product_details/widgets.dart';
import '../../const/text_style.dart';
import '../../model/shoe.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailsScreen({super.key, required this.shoe});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(hasTrailing: true, onTap: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(widget.shoe),
              SizedBox(height: 20.h),
              _buildProductDetails(widget.shoe),
              SizedBox(height: 20.h),
              _buildSizeSelection(widget.shoe.sizes),
              SizedBox(height: 20.h),
              _buildDescription(),
              SizedBox(height: 20.h),
              _buildReviews(widget.shoe),
              _buildAllReviewButton(onPressed: () {}),
              SizedBox(height: 20.h),
              _buildAddToCartSection(widget.shoe),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shoe.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Image.network(
                  shoe.images[index],
                  width: 252.w,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 20.w,
          bottom: 20.h,
          child: Row(
            children: [
              _buildDot(buttonBackground),
              SizedBox(
                width: 4.w,
              ),
              _buildDot(secondaryBackground2),
              SizedBox(
                width: 4.w,
              ),
              _buildDot(secondaryBackground2),
            ],
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
        Text(shoe.name, style: bodyText700Big),
        SizedBox(height: 10.h),
        Row(
          children: [
            RatingStars(rating: shoe.averageRating),
            SizedBox(width: 5.w),
            Text(
              shoe.averageRating.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.w),
            Text(
              '(${shoe.reviewCount} Reviews)',
              style: headline600small,
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
          color: buttonForeground, borderRadius: BorderRadius.circular(30.r)),
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
                    color: Color(int.parse(colors[index])),
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
                        color: buttonForeground,
                      ))
                else
                  const SizedBox.shrink()
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
        Text('Size', style: headline600small),
        SizedBox(height: 10.h),
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
                  color: isSelected ? buttonBackground : buttonForeground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.transparent : buttonBackground,
                  ),
                ),
                child: Text(sizes[index].toString(),
                    style: bodyText700SmallLight.copyWith(
                        color:
                            isSelected ? buttonForeground : buttonBackground)),
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
        Text('Description', style: headline600small),
        SizedBox(height: 10.h),
        Text(
          widget.shoe.description,
          overflow: TextOverflow.ellipsis,
          style: bodyText400LightMedium,
        ),
      ],
    );
  }

  Widget _buildReviews(Shoe shoe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews (${shoe.reviews.length})', style: headline600small),
        SizedBox(height: 10.h),
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
              SizedBox(height: 5.h),
              Text(review.comment, style: TextStyle(fontSize: 14.sp)),
              const Divider(),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildAddToCartSection(Shoe shoe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price', style: bodyText400Light),
            Text('\$${shoe.price}', style: bodyText700Big),
          ],
        ),
        KButton(height: 50.h,width: 156.w,
            text: 'ADD TO CART',onPressed: () {})
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
                borderRadius: BorderRadius.circular(100.r))),
        onPressed: onPressed,
        child: Text(
          'SEE ALL REVIEW',
          style: bodyText700Small,
        ),
      ),
    );
  }
}
