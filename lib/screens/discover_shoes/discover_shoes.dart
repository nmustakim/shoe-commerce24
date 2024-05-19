
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/screens/discover_shoes/widgets/shoe_card.dart';
import 'package:shoe_commerce/util/k_lists.dart';

import '../../provider/shoes_provider.dart';

class DiscoverShoes extends StatelessWidget {
   const DiscoverShoes({super.key});

  @override
  Widget build(BuildContext context) {
    final shoes = Provider.of<ShoesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('Discover',style:titleTextStyle1),
        actions: [
          Image.asset('assets/images/cart.png'),
          SizedBox(width: 16.w,)
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Consumer<ShoesProvider>(
          builder: (context, shoesProvider, child) => Column(
            children: [
              SizedBox(height: 10.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: shoesProvider.categories.map((category) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Chip(label: Text(category)),
                  )).toList(),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: shoesProvider.shoes.length,
                  itemBuilder: (context, index) {
                    return ShoeCard(shoe: shoesProvider.shoes[index],index: index,);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          // Implement your filter functionality here
        },
        child: Icon(Icons.filter_list),
      ),
    );
  }
}





