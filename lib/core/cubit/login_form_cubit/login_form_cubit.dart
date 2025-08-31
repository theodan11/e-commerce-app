import 'package:e_commerce_app/core/cubit/login_form_cubit/login_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormState());

  void updateEmailOrPhone(String emailOrPhone) {
    emit(state.copyWith(emailOrPhone: emailOrPhone));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateIsObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void resetForm() {
    emit(const LoginFormState());
  }

  void loadingInProgress() {
    emit(state.copyWith(isSubmitting: true, isSuccess: false));
  }

  void loadingSuccess() {
    emit(state.copyWith(isSubmitting: false, isSuccess: true));
  }

  void submitForm() {
    // print("Email: ${state.emailOrPhone}\nPassword: ${state.password} ");
  }
}
