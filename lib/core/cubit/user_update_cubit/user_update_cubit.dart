import 'package:e_commerce_app/core/cubit/user_update_cubit/user_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(UserUpdateState(fullname: '', imagePath: ''));

  void updateImagePath(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void updateFullname(String fullname) {
    emit(state.copyWith(fullname: fullname));
  }
}
