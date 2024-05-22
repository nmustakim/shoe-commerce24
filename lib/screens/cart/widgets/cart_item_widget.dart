import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onRemove,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 88.h,
            width: 88.w,
            decoration: BoxDecoration(
              color: secondaryBackground1,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.network(cartItem.image),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.name,
                  style: headlineW600F16,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${cartItem.brand} ${cartItem.color} . ${cartItem.size}',
                  style: bodyTextW400F12Light.copyWith(color: const Color(0XFF666666)),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${cartItem.price}',
                      style: bodyTextW700F14Dark,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: secondaryBackground2, size: 24.sp),
                            onPressed: onRemove,
                          ),
                          Text(
                            cartItem.quantity.toString(),
                            style: bodyTextW700F14Dark,
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, size: 24.sp),
                            onPressed: onAdd,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
