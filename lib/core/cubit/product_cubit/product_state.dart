import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final String? imagePath;
  final String? title;
  final double? price;
  final int? stock;
  final String? vendorID;
  final String? desc;
  final bool isLoading;
  final bool isSuccess;

  const ProductState({
    this.imagePath = '',
    this.title = '',
    this.price = 0,
    this.stock = 0,
    this.vendorID = '',
    this.desc = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  ProductState copyWith({
    String? imagePath,
    String? title,
    double? price,
    int? stock,
    String? vendorID,
    String? desc,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ProductState(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      vendorID: vendorID ?? this.vendorID,
      desc: desc ?? this.desc,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        title,
        imagePath,
        price,
        stock,
        vendorID,
        desc,
        isLoading,
        isSuccess,
      ];
}
