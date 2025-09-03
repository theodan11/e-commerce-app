import '../product_list_cubit/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });
}
