import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/cart_cubit/cart_state.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Mega Mall",
        style: MyTextTheme.appBarTitle,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),

        // Stack(
        //   children: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.shopping_cart_outlined),
        //     ),
        //     Positioned(
        //         left: 0,
        //         top: 0,
        //         child: BlocListener<CartCubit, CartState>(
        //           listener: (context, state) {
        //             if (state.cartItemCount > 0) {
        //               ClipRRect(
        //                 borderRadius: BorderRadius.circular(50),
        //                 child: Container(
        //                   width: 18,
        //                   height: 18,
        //                   decoration: const BoxDecoration(
        //                       color: MyThemeColors.productPriceColor),
        //                   child: Center(
        //                     child: Text(
        //                       state.cartItemCount.toString(),
        //                       style: const TextStyle(color: Colors.white),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             } else {
        //               const SizedBox();
        //             }
        //           },
        //         ))
        //   ],
        // )

        BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          return Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              (state.cartItemCount > 0)
                  ? Positioned(
                      left: 0,
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                              color: MyThemeColors.productPriceColor),
                          child: Center(
                            child: Text(
                              (state.cartItemCount).toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        })
      ],
    );
  }
}
