import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState());

  void updateEmailOrPhone(String emailOrPhone) {
    emit(state.copyWith(emailOrPhone: emailOrPhone));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateIsObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void updateReferalCode(String referalCode) {
    emit(state.copyWith(referalCode: referalCode));
  }
}
