import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListState(productList: []));

  Future<void> fetchProduct() async {
    emit(state.copyWith(isLoading: true));

    try {
      List<ProductModel> plist;
      final productSnapshot =
          await FirebaseFirestore.instance.collection("products").get();

      plist = productSnapshot.docs.map((doc) {
        return ProductModel.fromJSON(doc.data(), doc.id);
      }).toList();
      // print(plist);
      emit(
        state.copyWith(
          productList: plist,
          isLoading: false,
          isSuccess: true,
        ),
      );
    } on FirebaseException catch (e) {
      print(e.message.toString());
      emit(
        state.copyWith(
            isSuccess: false,
            isLoading: false,
            error: "message from cubit product list ${e.message}"),
      );
    } catch (e) {
      print(e);

      emit(state.copyWith(
          isSuccess: false,
          isLoading: false,
          error: "message from cubit product list $e"));
    }
  }
}
