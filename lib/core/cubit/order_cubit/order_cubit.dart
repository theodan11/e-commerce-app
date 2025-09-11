import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_model.dart';
import 'package:e_commerce_app/core/cubit/order_cubit/order_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState(orderLists: []));

  Future<void> fetchOrders() async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    String customerId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot ordersnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .where("customerId", isEqualTo: customerId)
        .get();

    List<OrderModel> ordersList = ordersnapshot.docs.map((doc) {
      return OrderModel(
          createdAt: doc['createdAt'],
          items: doc["items"],
          orderId: doc.id,
          status: doc["status"],
          totalPrice: doc["totalPrice"]);
    }).toList();

    emit(state.copyWith(
        orderLists: ordersList, isLoading: false, isSuccess: true));
  }
}
