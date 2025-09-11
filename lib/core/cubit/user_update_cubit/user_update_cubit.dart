import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/user_update_cubit/user_update_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(const UserUpdateState(fullname: '', imagePath: ''));

  void updateImagePath(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void updateFullname(String fullname) {
    emit(state.copyWith(fullname: fullname));
    // print(state.fullname);
  }

  Future<void> fetchUser() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      dynamic user =
          UserUpdateState.fromJSON(userSnapshot.data() as Map<String, dynamic>);

      emit(state.copyWith(fullname: user.fullname, imagePath: user.imagePath));
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateUser() async {
    // print(state.fullname);
    // print(state.imagePath);

    emit(state.copyWith(isLoading: true, isSuccess: false));
    Map<String, dynamic> userData = {};
    if (state.fullname != '') {
      userData['fullname'] = state.fullname;
      // print(" this is data map $userData");
    }
    if (state.imagePath != '') {
      userData["imagePath"] = state.imagePath;
    }
    try {
      // print("on");
      // print(userData);
      // print(FirebaseAuth.instance.currentUser!.uid);
      if (userData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(userData);
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, error: "No data to update"));
        throw Exception("No data to update");
      }
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          isLoading: false, isSuccess: false, error: e.message.toString()));
      throw Exception(e.message);
    }
  }

  void resetForm() {
    emit(const UserUpdateState(imagePath: '', fullname: ''));
  }
}
