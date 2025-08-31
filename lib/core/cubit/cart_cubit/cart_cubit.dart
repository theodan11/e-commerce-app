import 'package:e_commerce_app/core/cubit/cart_cubit/cart_item_model.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(cartItem: []));

  void addToCart(ProductModel product, int quantity) {
    List<CartItemModel> copyOfCartItemList =
        List<CartItemModel>.from(state.cartItem);

    int index = copyOfCartItemList.indexWhere((item) {
      return item.product.id == product.id;
    });

    if (index != -1) {
      final updatedItem = CartItemModel(
          product: product,
          quantity: copyOfCartItemList[index].quantity + quantity);
      copyOfCartItemList[index] = updatedItem;
    } else {
      copyOfCartItemList
          .add(CartItemModel(product: product, quantity: quantity));
    }
    // int cartC = cartCount();
    double totalPrice = _totalPriceCalculate(copyOfCartItemList);
    emit(state.copyWith(
      cartItem: copyOfCartItemList,
      totalShoppingPrice: totalPrice,
    ));
  }

  void removeFromCart(ProductModel product, int quantity) {
    List<CartItemModel> copyOfCartItemList =
        List<CartItemModel>.from(state.cartItem);

    int index = copyOfCartItemList.indexWhere((item) {
      return item.product.id == product.id;
    });

    if (index != -1) {
      int updatedQuantity = copyOfCartItemList[index].quantity - quantity;

      if (updatedQuantity > 0) {
        final updatedItem = CartItemModel(
          product: product,
          quantity: updatedQuantity,
        );
        copyOfCartItemList[index] = updatedItem;
      } else {
        copyOfCartItemList.removeAt(index);
      }
    }
    // int cartC = cartCount();
    double totalPrice = _totalPriceCalculate(copyOfCartItemList);

    emit(state.copyWith(
      cartItem: copyOfCartItemList,
      totalShoppingPrice: totalPrice,
    ));
  }

  void increaseQuantity({int? index}) {
    if (index != null) {
      List<CartItemModel> existingCart =
          List<CartItemModel>.from(state.cartItem);
      int updatedQuantity = existingCart[index].quantity + 1;
      ProductModel existingProduct = existingCart[index].product;
      existingCart[index] =
          CartItemModel(product: existingProduct, quantity: updatedQuantity);
      double totalPrice = _totalPriceCalculate(existingCart);
      emit(state.copyWith(
          cartItem: existingCart, totalShoppingPrice: totalPrice));
    }
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decreaseQuantity({int? index}) {
    if (index != null) {
      List<CartItemModel> existingCart =
          List<CartItemModel>.from(state.cartItem);
      int updatedQuantity = existingCart[index].quantity - 1;
      ProductModel existingProduct = existingCart[index].product;
      // double totalPrice = _totalPriceCalculate(existingCart);
      if (updatedQuantity <= 0) {
        existingCart.removeAt(index);
        double totalPrice = _totalPriceCalculate(existingCart);
        //  CartItemModel cartItems = CartItemModel(product: product, quantity: quantity)
        emit(state.copyWith(
            cartItem: existingCart,
            cartItemCount: existingCart.length,
            totalShoppingPrice: totalPrice));
      } else {
        // existingCart.removeAt(index);
        existingCart[index] =
            CartItemModel(product: existingProduct, quantity: updatedQuantity);
        double totalPrice = _totalPriceCalculate(existingCart);
        emit(state.copyWith(
            cartItem: existingCart, totalShoppingPrice: totalPrice));
      }
    }
    if (state.quantity > 0) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void resetQuantity() {
    emit(state.copyWith(quantity: 1));
  }

  double _totalPriceCalculate(dynamic cartItem) {
    return cartItem.fold(0.0, (sum, item) {
      return sum + (item.product.price * item.quantity);
    });
  }

  void cartCount() {
    emit(state.copyWith(cartItemCount: state.cartItem.length));
  }
}
