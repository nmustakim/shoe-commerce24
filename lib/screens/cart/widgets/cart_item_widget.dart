import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/const/color.dart';
import 'package:shoe_commerce/const/img_asset.dart';
import 'package:shoe_commerce/const/text_style.dart';
import 'package:shoe_commerce/global_widgets/kbutton.dart';
import 'package:shoe_commerce/models/cart_item.dart';
import 'package:shoe_commerce/providers/cart_provider.dart';

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
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,

      background: Container(alignment:Alignment.centerRight,child: SvgPicture.asset(ImageAsset.deleteIcon)),
      confirmDismiss: (direction) async {
        // Confirm delete action
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Alert!",
                style: headlineW700F18Dark,
              ),
              content: Text(
                "Are you sure you want to delete this item?",
                style: headlineW600F16,
              ),
              actions: <Widget>[
                KButton(
                    text: 'CANCEL',
                    onPressed: () => Navigator.of(context).pop(false)),
                KButton(
                    text: 'DELETE',
                    backgroundColor: secondaryBackgroundRed,
                    onPressed: () => Navigator.of(context).pop(true))
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeFromCart(cartItem);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 88.h,
              width: 88.w,
              decoration: BoxDecoration(
                color: secondaryBackgroundWhite1,
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
                    '${cartItem.brand} ${cartItem.color} ${cartItem.size}',
                    style: bodyTextW400F12Light.copyWith(
                      color: const Color(0XFF666666),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartItem.price.toStringAsFixed(2)}',
                        style: bodyTextW700F14Dark,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: onRemove,
                                child: SvgPicture.asset(ImageAsset.remove,height:24.w ,width: 24.w,)),
                            SizedBox(
                              width: 24.w,
                              child: Center(
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: bodyTextW700F14Dark,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onAdd,
                                child: SvgPicture.asset(ImageAsset.add,height:24.w ,width: 24.w,)),

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
      ),
    );
  }
}
