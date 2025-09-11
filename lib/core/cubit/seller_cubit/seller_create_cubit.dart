import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/seller_cubit/seller_create_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerCreateCubit extends Cubit<SellerCreateState> {
  SellerCreateCubit()
      : super(
          const SellerCreateState(
            storeName: '',
            imagePath: '',
            address: '',
          ),
        );

  void addTitle(String title) {
    // print(state);
    emit(state.copyWith(storeName: title));
  }

  void addAdrress(String address) {
    // print(state);
    emit(state.copyWith(address: address));
  }

  void addImagePath(String imagePath) {
    // print(state);
    emit(state.copyWith(imagePath: imagePath));
  }

  void resetForm() {
    emit(const SellerCreateState(storeName: '', imagePath: '', address: ''));
  }

  Future<void> uploadToCloud() async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      await FirebaseFirestore.instance.collection("store").add({
        "storeOwner": FirebaseAuth.instance.currentUser!.uid,
        "imagePath": state.imagePath,
        "storeName": state.storeName,
        "address": state.address,
        "createdAt": FieldValue.serverTimestamp(),
        "followers": [],
        "products": [],
        "rating": 0.0,
      });

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseException catch (e) {
      // print(e.message);
    }
  }
}
