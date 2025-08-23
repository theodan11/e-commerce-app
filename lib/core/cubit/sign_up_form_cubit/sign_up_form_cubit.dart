import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState());

  void updateEmailOrPhone(String emailOrPhone) {
    emit(
      state.copyWith(
        emailOrPhone: emailOrPhone,
        isEmailValid: _isEmailValid(state.emailOrPhone!),
      ),
    );
  }

  void updateFullName(String fullname) {
    emit(
      state.copyWith(
        fullName: fullname,
        isProfileValid: _isProfileValid(state.fullName!, state.password),
      ),
    );
  }

  void updatePassword(String password) {
    emit(
      state.copyWith(
        password: password,
        isProfileValid: _isProfileValid(state.fullName!, state.password),
      ),
    );
  }

  void updateIsObscure() {
    emit(
      state.copyWith(isObscure: !state.isObscure),
    );
  }

  void updateReferalCode(String referalCode) {
    emit(
      state.copyWith(referalCode: referalCode),
    );
  }

  bool _isEmailValid(String emailOrPhone) {
    if (emailOrPhone.isNotEmpty) {
      // print(state.isEmailValid);
      return true;
    }

    return false;
  }

  bool _isProfileValid(String? fullName, String? password) {
    return (fullName?.isNotEmpty ?? false) &&
        (password?.isNotEmpty ?? false) &&
        (password!.length >= 6);
  }
}
