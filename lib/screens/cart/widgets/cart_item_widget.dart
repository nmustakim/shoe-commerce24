import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
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
        children: [
          Container(
            height: 88.h,
            width: 88.w,
            decoration: BoxDecoration(
                color: secondaryBackground1,
                borderRadius: BorderRadius.circular(20.r)),
            child: Image.network(cartItem.shoe.images.first),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.shoe.name,
                  style: headline600small,
                ),
                SizedBox(height: 4.h),
                Text(
                  '  ${cartItem.shoe.colors.first} . ${cartItem.shoe.sizes.first}',
                  style: bodyText400Light.copyWith(color: const Color(0XFF666666)),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${cartItem.shoe.price}',
                      style: bodyText700Small,
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
                            style: bodyText700Small,
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, size: 24.sp),
                            onPressed: onAdd,
                          ),
                        ],
                      ),
                    )
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
