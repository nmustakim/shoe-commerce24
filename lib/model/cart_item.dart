import 'package:shoe_commerce/model/shoe.dart';

class CartItem {
  final Shoe shoe;
  final int quantity;

  CartItem({required this.shoe, required this.quantity});

  CartItem copyWith({Shoe? shoe, int? quantity}) {
    return CartItem(
      shoe: shoe ?? this.shoe,
      quantity: quantity ?? this.quantity,
    );
  }
}
