import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/text_style.dart';
import '../../global_widgets/kappbar.dart';
import '../../model/shoe.dart';


class ReviewScreen extends StatefulWidget {
final Shoe shoe;


  const ReviewScreen({
    super.key,
  required this.shoe
  });

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  int? selectedStar; // null means "All"

  List<Review> get filteredReviews {
    if (selectedStar == null) {
      return widget.shoe.reviews;
    }
    return widget.shoe.reviews.where((review) => review.rating == selectedStar).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: KAppBar(
          hasTitle: true,
          title: 'Review (${widget.shoe.reviewCount})',
          isDiscoverScreen: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      Text(widget.shoe.averageRating.toString(), style: headlineW600F20),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStar = index == 0 ? null : 6 - index;
                      });
                    },
                    child: Text(
                      index == 0 ? 'All' : '${6 - index} Stars',
                      style: selectedStar == (index == 0 ? null : 6 - index)
                          ? bodyTextW700F14Dark
                          : bodyTextW400F14Light,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredReviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewItem(filteredReviews[index]);
                  },
                ),
              ),
            ],
          ),
        ),

    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(review.userId, style: bodyTextW700F14Dark),
                    Text(review.timestamp.toString(), style: bodyTextW400F11Light),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < review.rating ? Colors.yellow : Colors.grey,
                      size: 16.sp,
                    );
                  }),
                ),
                SizedBox(height: 4.h),
                Text(review.comment, style: bodyTextW400F14Light),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
