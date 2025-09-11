import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState()) {
    const ProductState();
  }

  void updateAll(String title, String imagePath, String desc, double price,
      int stock, double originalPrice, bool isDiscount) {
    emit(ProductState(
      title: title,
      imagePath: imagePath,
      desc: desc,
      price: price,
      originalPrice: originalPrice,
      stock: stock,
      isDiscount: isDiscount,
    ));
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

  void updateVendorID(String storeId) {
    emit(state.copyWith(storeId: storeId));
  }

  void updateOriginalPrice(double originalPrice) {
    emit(state.copyWith(originalPrice: originalPrice));
  }

  void updateIsDiscount(bool isDiscount) {
    emit(state.copyWith(isDiscount: isDiscount));
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

  Future<void> updateProduct(String productId) async {
    // title: state.title,
    // price: state.price,
    // imagePath: state.imagePath,
    // stock: state.stock,
    // desc: state.desc,
    // isDiscount: state.isDiscount,
    // originalPrice: state.originalPrice,
    try {
      Map<String, dynamic> updatedData = {};
      if (state.title != '') {
        updatedData['title'] = state.title;
      }
      if (state.price != 0) {
        updatedData['price'] = state.price;
      }
      if (state.imagePath != '') {
        updatedData['imagePath'] = state.imagePath;
      }
      if (state.stock != 0) {
        updatedData['stock'] = state.stock;
      }
      if (state.desc != '') {
        updatedData['desc'] = state.desc;
      }
      if (state.isDiscount != null) {
        updatedData['isDiscount'] = state.isDiscount;
      }
      if (state.originalPrice != 0.0) {
        updatedData['originalPrice'] = state.originalPrice;
      }

      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .update(updatedData);

      emit(state.copyWith(isLoading: true, isSuccess: false));
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
