import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/cubit/user_store_product_cubit/user_store_product_list_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserStoreProductListCubit extends Cubit<UserStoreProductListState> {
  UserStoreProductListCubit()
      : super(const UserStoreProductListState(productList: []));

  // Future<void> fetchStoreInfo() async {
  //   Map<String, dynamic> storeInfo =
  //       await FirebaseDbServices().fetchOwnerStore();

  //   emit(state.copyWith(storeInfo: storeInfo));
  // }
  Future<void> fetchStoreInfo() async {
    try {
      final storeSnapshot =
          await FirebaseFirestore.instance.collection("store").get();

      // print(storeSnapshot);
// final storeData = storeSnapshot.docs.where((item) {
//         return item['storeOwner'] == user;
//       });
      final storeInfo = storeSnapshot.docs.firstWhere((item) {
        return item['storeOwner'] == FirebaseAuth.instance.currentUser!.uid;
      });

      // return storeInfo;
      emit(state.copyWith(storeInfo: {
        "id": storeInfo.id,
        ...storeInfo.data(),
      }));
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  // Future<void> fetchProductWithStoreId(String storeId) async {
  //   dynamic products = await FirebaseDbServices().fetchProduct(storeId);
  //   List<ProductModel> productsList = products.map((product) {
  //     return ProductModel.fromJSON(products, product['id']);
  //   });

  //   emit(state.copyWith(productList: productsList));
  // }

  Future<void> fetchProductWithStoreId() async {
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      if (state.storeInfo.isNotEmpty) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("products")
            .where("storeId", isEqualTo: state.storeInfo['id'])
            .get();

        // print(querySnapshot.docs);

        List<ProductModel> products = querySnapshot.docs.map((doc) {
          return ProductModel.fromJSON(doc.data(), doc.id);
        }).toList();

        emit(state.copyWith(
            productList: products, isLoading: false, isSuccess: true));
      }
    } on FirebaseException catch (e) {
      // print(e.message);
    }
  }
}
