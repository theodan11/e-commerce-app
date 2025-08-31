import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (state.cartItemCount <= 0) {
          return const Center(
            child: Text("Cart is empty."),
          );
        }

        return const Center(child: Text("Hello "));
      })),
    );
  }
}
