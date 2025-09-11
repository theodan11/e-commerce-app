import 'package:e_commerce_app/core/cubit/order_cubit/order_model.dart';
import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  final List<OrderModel> orderLists;
  final bool isLoading;
  final bool isSuccess;

  const OrderState(
      {required this.orderLists,
      this.isLoading = false,
      this.isSuccess = false});

  OrderState copyWith({
    List<OrderModel>? orderLists,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return OrderState(
        orderLists: orderLists ?? this.orderLists,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  @override
  List<Object?> get props => [orderLists, isLoading, isSuccess];
}
