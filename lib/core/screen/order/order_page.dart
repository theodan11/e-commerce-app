import 'package:e_commerce_app/core/common/login_please.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_cubit.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_model.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_state.dart';
import 'package:e_commerce_app/core/screen/order/order_single_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      context.read<OrderCubit>().fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Orders",
      //       style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.orderLists.isNotEmpty) {
              const Center(
                child: CircularProgressIndicator(
                  color: MyThemeColors.primaryColor,
                ),
              );
            }

            if (FirebaseAuth.instance.currentUser?.uid == null) {
              return const LoginPlease(
                buttonTitle: "Login",
              );
            }

            return Padding(
              padding: const EdgeInsets.all(25),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: state.orderLists.length,
                  itemBuilder: (context, index) {
                    OrderModel order = state.orderLists[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OrderSinglePage(order: order)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyThemeColors.primaryColor
                                    .withValues(alpha: 0.5)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID: ${order.orderId}"),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("৳ ${order.totalPrice}tk"),
                                  Text(order.status,
                                      style: TextStyle(
                                        color: order.status == 'PENDING'
                                            ? MyThemeColors.primaryColor
                                            : order.status == "CANCELED"
                                                ? MyThemeColors
                                                    .productPriceColor
                                                : MyThemeColors.greenCardColor,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
