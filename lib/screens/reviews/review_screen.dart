
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/screens/reviews/widget/review_shimmer.dart';
import 'package:shoe_commerce/screens/reviews/widget/review_widget.dart';

import '../../const/text_style.dart';
import '../../global_widgets/k_appbar.dart';

import '../../models/shoe.dart';
import '../../providers/review_provider.dart';

class ReviewScreen extends StatefulWidget {
  final Shoe shoe;

  const ReviewScreen({super.key, required this.shoe});

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  int? selectedStar;

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    return Scaffold(
      appBar: KAppBar(
        hasTitle: true,
        hasTrailing: true,
        isReviewScreen: true,
        rating: widget.shoe.averageRating.toString(),
        title: 'Review (${widget.shoe.reviewCount})',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStar = index == 0 ? null : 6 - index;
                      });
                      if(index ==0){
                        reviewProvider.fetchReviews(widget.shoe.id,);
                      }
                      else {
                        reviewProvider.getReviewsByStar(
                            shoeId: widget.shoe.id,
                            rating: selectedStar);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Text(
                        index == 0 ? 'All' : '${6 - index} Stars',
                        style: selectedStar == (index == 0 ? null : 6 - index)
                            ? headlineW700F20Dark
                            : headlineW700F20Light,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: reviewProvider.isLoading?const ReviewShimmerLoadingList(itemCount: 5):ListView.builder(
                itemCount: reviewProvider.filteredReviews.length,
                itemBuilder: (context, index) {
                  return buildReviewItem(reviewProvider.filteredReviews[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
