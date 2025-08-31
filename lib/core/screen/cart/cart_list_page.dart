import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (state.cartItemCount <= 0) {
          return const Center(
            child: Text("Cart is empty."),
          );
        }

        return Center(
            child: ListView.builder(
                itemCount: state.cartItemCount,
                itemBuilder: (context, index) {
                  var cartItem = state.cartItem[index];
                  return Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 120,
                            child: Image.network(
                              cartItem.product.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          (cartItem.product.title.length > 20
                              ? Text(
                                  "${cartItem.product.title.substring(0, 20)}...")
                              : Text(cartItem.product.title)),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              context.read<CartCubit>().decreaseQuantity();
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: MyThemeColors.grayText,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                              child: Text(
                                cartItem.quantity.toString(),
                                style: MyTextTheme.loginPageLabel,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (cartItem.quantity < cartItem.product.stock) {
                                context.read<CartCubit>().increaseQuantity();

                                // print(state.cartItemCount);
                                // print(state.cartItem);
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: MyThemeColors.grayText,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }));
      })),
    );
  }
}
