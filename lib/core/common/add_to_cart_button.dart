import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  dynamic productItem;

  AddToCartButton({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("add to cart pressed");
        context.read<CartCubit>().resetQuantity();
        double totalPriceLocal = productItem.price;
        showDialog(
            context: context,
            builder: (context) {
              return BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                return AlertDialog(
                  title: const Text("Add to Cart"),
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: .8,
                          height: 2,
                          color: MyThemeColors.grayText,
                        ),
                        Row(
                          children: [
                            const Text("Quantity"),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                totalPriceLocal =
                                    productItem.price * (state.quantity - 1);
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
                                  state.quantity.toString(),
                                  style: MyTextTheme.loginPageLabel,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (state.quantity < productItem.stock) {
                                  totalPriceLocal =
                                      productItem.price * (state.quantity + 1);
                                  context.read<CartCubit>().increaseQuantity();

                                  print(state.cartItemCount);
                                  print(state.cartItem);
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                color: MyThemeColors.grayText,
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          indent: 25,
                          endIndent: 25,
                          thickness: .8,
                          height: 8,
                          color: MyThemeColors.grayText,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Total Shopping",
                            style: MyTextTheme.loginPageLabel),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("\$ ${totalPriceLocal.toString()}",
                            style: MyTextTheme.productPrice
                                .copyWith(color: Colors.black87)),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            context
                                .read<CartCubit>()
                                .addToCart(productItem, state.quantity);
                            context.read<CartCubit>().cartCount();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Added to Cart",
                              ),
                              backgroundColor: MyThemeColors.categoriesGreen,
                            ));
                          },
                          child: Container(
                            width: 325,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyThemeColors.primaryColor),
                            child: Center(
                              child: Text(
                                "Add to Cart",
                                style: MyTextTheme.searchHintText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              });
            });
      },
      child: Container(
        width: 325,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyThemeColors.primaryColor),
        child: Center(
          child: Text(
            "Add to Cart",
            style: MyTextTheme.searchHintText.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
