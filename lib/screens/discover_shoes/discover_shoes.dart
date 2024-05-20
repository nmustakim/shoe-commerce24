import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/screens/discover_shoes/widgets/shoe_card.dart';

import '../../provider/shoes_provider.dart';

class DiscoverShoes extends StatelessWidget {
  const DiscoverShoes({super.key});

  @override
  Widget build(BuildContext context) {
    final shoes = Provider.of<ShoesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Discover', style: headline700),
        actions: [
          Image.asset('assets/images/cart.png'),
          SizedBox(
            width: 16.w,
          )
        ],
      ),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.h),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Container(
                margin: EdgeInsets.only(left: 8.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: shoesProvider.categories.map<Widget>((category) {
                      int index = shoesProvider.categories.indexOf(category);
                      return Row(
                        children: [
                          //Avoid adding sizedbox if it it the left most text
                          if (index > 0) SizedBox(width: 16.w),
                          Text(category, style: headline600.copyWith(letterSpacing: 1)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: shoesProvider.shoes.length,
                  itemBuilder: (context, index) {
                    return ShoeCard(
                      shoe: shoesProvider.shoes[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
