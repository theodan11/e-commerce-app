import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/review_cubit/review_create_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCreateCubit extends Cubit<ReviewCreateState> {
  ReviewCreateCubit() : super(const ReviewCreateState());

  void updateRating(int value) {
    print(value);
    emit(state.copyWith(rating: value));
  }

  void updateCustomerExperience(String review) {
    emit(state.copyWith(customerExperience: review));
  }

  void resetForm() {
    emit(const ReviewCreateState());
  }

  Future<void> saveReview(String productId) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      DocumentSnapshot user = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic> data = user.data() as Map<String, dynamic>;
      print("on");
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .update({
        "reviews": FieldValue.arrayUnion([
          {
            "userName": data['fullname'],
            "imagePath": FirebaseAuth.instance.currentUser!.photoURL,
            "rating": state.rating ?? 0,
            "review": state.customerExperience,
            "createdAt": Timestamp.now(),
          }
        ])
      });
      print("off");

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseException catch (e) {
      print(e.message.toString());
      emit(state.copyWith(isLoading: false, isSuccess: false));
    }
  }
}
