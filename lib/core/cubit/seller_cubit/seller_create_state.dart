import 'package:equatable/equatable.dart';

class SellerCreateState extends Equatable {
  final String storeName;
  final String imagePath;
  final String address;
  final bool isLoading;
  final bool isSuccess;

  const SellerCreateState({
    this.storeName = '',
    this.imagePath = '',
    this.address = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  SellerCreateState copyWith({
    String? storeName,
    String? imagePath,
    String? address,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return SellerCreateState(
      storeName: storeName ?? this.storeName,
      imagePath: imagePath ?? this.imagePath,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        storeName,
        imagePath,
        address,
        isLoading,
        isSuccess,
      ];
}
