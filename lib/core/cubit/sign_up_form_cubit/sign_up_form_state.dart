import 'package:equatable/equatable.dart';

class SignUpFormState extends Equatable {
  final String? emailOrPhone;
  final String? fullName;
  final String? password;
  final String? referalCode;
  final bool isObscure;

  const SignUpFormState(
      {this.fullName = '',
      this.emailOrPhone = '',
      this.password = '',
      this.isObscure = true,
      this.referalCode = ''});

  @override
  List<Object?> get props => [emailOrPhone, password, referalCode, isObscure];

  SignUpFormState copyWith(
      {String? emailOrPhone,
      String? fullName,
      String? password,
      String? referalCode,
      bool? isObscure}) {
    return SignUpFormState(
        emailOrPhone: emailOrPhone ?? this.emailOrPhone,
        password: password ?? this.password,
        fullName: fullName ?? this.fullName,
        referalCode: referalCode ?? this.referalCode,
        isObscure: isObscure ?? this.isObscure);
  }

  bool get isEmailValid {
    if (emailOrPhone!.isNotEmpty) return true;
    return false;
  }

  bool get isProfileValid {
    if (fullName!.isNotEmpty && password!.isNotEmpty && password!.length > 6) {
      return true;
    }
    return false;
  }
}
