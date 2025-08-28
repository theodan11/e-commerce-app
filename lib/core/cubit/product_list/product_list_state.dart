import 'package:e_commerce_app/core/cubit/product_list/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductListState extends Equatable {
  final List<ProductModel> productList;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  const ProductListState({
    required this.productList,
    this.isLoading = false,
    this.isSuccess = false,
    this.error = '',
  });

  ProductListState copyWith(
      {List<ProductModel>? productList,
      bool? isLoading,
      bool? isSuccess,
      String? error}) {
    return ProductListState(
      productList: productList ?? this.productList,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [productList, isLoading, isSuccess, error];
}
