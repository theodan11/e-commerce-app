import 'package:e_commerce_app/core/cubit/cart_cubit/cart_item_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItem;
  final double totalShoppingPrice;
  final int quantity;
  final int cartItemCount;

  const CartState({
    required this.cartItem,
    this.totalShoppingPrice = 0,
    this.cartItemCount = 0,
    this.quantity = 1,
  });

  CartState copyWith({
    List<CartItemModel>? cartItem,
    double? totalShoppingPrice,
    int? quantity,
    int? cartItemCount,
  }) {
    return CartState(
      cartItem: cartItem ?? this.cartItem,
      totalShoppingPrice: totalShoppingPrice ?? this.totalShoppingPrice,
      quantity: quantity ?? this.quantity,
      cartItemCount: cartItemCount ?? this.cartItemCount,
    );
  }

  @override
  List<Object?> get props =>
      [cartItem, totalShoppingPrice, quantity, cartItemCount];
}
