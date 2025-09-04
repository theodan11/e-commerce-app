import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';

import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartItemCount <= 0) {
              return const Center(
                child: Text("Cart is empty."),
              );
            }
            MoneyFormatter money =
                MoneyFormatter(amount: state.totalShoppingPrice);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount: state.cartItemCount,
                        itemBuilder: (context, index) {
                          var cartItem = state.cartItem[index];
                          MoneyFormatter itemPrice =
                              MoneyFormatter(amount: cartItem.product.price);
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (cartItem.product.title.length > 20
                                          ? Text(
                                              "${cartItem.product.title.substring(0, 12)}...",
                                              style: MyTextTheme.productTitle,
                                            )
                                          : Text(
                                              cartItem.product.title,
                                              style: MyTextTheme.productTitle,
                                            )),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "৳ ${itemPrice.output.nonSymbol}",
                                        style: MyTextTheme.productPrice,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<CartCubit>()
                                          .decreaseQuantity(index: index);
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
                                      if (cartItem.quantity <
                                          cartItem.product.stock) {
                                        context
                                            .read<CartCubit>()
                                            .increaseQuantity(index: index);
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
                        },
                      ),
                    ),
                    const Divider(
                      color: MyThemeColors.grayText,
                    ),
                    Row(
                      children: [
                        Text("Total: ",
                            style: MyTextTheme.productPrice
                                .copyWith(color: Colors.black87, fontSize: 18)),
                        const Spacer(),
                        Text(
                          "৳ ${money.output.nonSymbol}",
                          style: MyTextTheme.productPrice
                              .copyWith(color: Colors.black87, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                        } else {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("orders")
                              .add({
                            "items": state.cartItem.map((item) {
                              return {
                                "product": {
                                  "productId": item.product.id,
                                  "productTitle": item.product.title,
                                  "productPrice": item.product.price,
                                },
                                "quantity": item.quantity,
                                "price": item.quantity * item.product.price
                              };
                            }).toList(),
                            "totalPrice": state.totalShoppingPrice,
                            "createdAt": FieldValue.serverTimestamp(),
                            "status": "PENDING"
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Checkout Successful"),
                                backgroundColor: MyThemeColors.categoriesGreen),
                          );

                          Navigator.of(context).pop();
                          context.read<CartCubit>().cartReset();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyThemeColors.primaryColor),
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: MyTextTheme.searchHintText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
