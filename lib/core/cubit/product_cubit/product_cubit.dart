import 'package:e_commerce_app/core/cubit/product_cubit/product_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState()) {
    const ProductState();
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateImagePath(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void updateDesc(String desc) {
    emit(state.copyWith(desc: desc));
  }

  void updatePrice(double price) {
    emit(state.copyWith(price: price));
  }

  void updateStock(int stock) {
    emit(state.copyWith(stock: stock));
  }

  void updateVendorID(String vendorID) {
    emit(state.copyWith(vendorID: vendorID));
  }

  void loadingInProgress() {
    emit(state.copyWith(isLoading: true, isSuccess: false));
  }

  void loadingSuccess() {
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void resetProductForm() {
    emit(const ProductState());
  }
}
