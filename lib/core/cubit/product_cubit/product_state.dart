import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final String? imagePath;
  final String? title;
  final double? price;
  final double? originalPrice;
  final bool? isDiscount;
  final int? stock;
  final String? storeId;
  final String? desc;
  final bool isLoading;
  final bool isSuccess;

  const ProductState({
    this.imagePath = '',
    this.title = '',
    this.price = 0,
    this.originalPrice = 0.0,
    this.stock = 0,
    this.storeId = '',
    this.desc = '',
    this.isDiscount = false,
    this.isLoading = false,
    this.isSuccess = false,
  });

  ProductState copyWith({
    String? imagePath,
    String? title,
    double? price,
    double? originalPrice,
    int? stock,
    String? storeId,
    String? desc,
    bool? isDiscount,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ProductState(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      stock: stock ?? this.stock,
      storeId: storeId ?? this.storeId,
      desc: desc ?? this.desc,
      isDiscount: isDiscount ?? this.isDiscount,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        title,
        imagePath,
        price,
        originalPrice,
        stock,
        storeId,
        desc,
        isLoading,
        isSuccess,
        isDiscount
      ];
}
