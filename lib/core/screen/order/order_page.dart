import 'package:e_commerce_app/core/cubit/order_cubit/order_cubit.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_model.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_state.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  initState() {
    super.initState();
    context.read<OrderCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator(
                color: MyThemeColors.primaryColor,
              );
            }
            return ListView.builder(
                itemCount: state.orderLists.length,
                itemBuilder: (context, index) {
                  OrderModel order = state.orderLists[index];
                  return Text("${order.orderId} -- ${order.status}");
                });
          },
        ),
      ),
    );
  }
}
