import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:equatable/equatable.dart';

class UserStoreProductListState extends Equatable {
  final List<ProductModel> productList;
  final Map<String, dynamic> storeInfo;
  final bool isLoading;
  final bool isSuccess;

  const UserStoreProductListState({
    required this.productList,
    this.storeInfo = const {},
    this.isLoading = false,
    this.isSuccess = false,
  });

  UserStoreProductListState copyWith({
    List<ProductModel>? productList,
    Map<String, dynamic>? storeInfo,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return UserStoreProductListState(
      productList: productList ?? this.productList,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      storeInfo: storeInfo ?? this.storeInfo,
    );
  }

  @override
  List<Object?> get props => [productList, isLoading, isSuccess, storeInfo];
}
