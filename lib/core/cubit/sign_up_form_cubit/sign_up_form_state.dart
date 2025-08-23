import 'package:equatable/equatable.dart';

class SignUpFormState extends Equatable {
  final String? emailOrPhone;
  final String? fullName;
  final String? password;
  final String? referalCode;
  final bool isObscure;
  final bool isEmailValid;
  final bool isProfileValid;
  final bool isLoading;

  const SignUpFormState({
    this.fullName = '',
    this.emailOrPhone = '',
    this.password = '',
    this.isObscure = true,
    this.referalCode = '',
    this.isEmailValid = false,
    this.isProfileValid = false,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        emailOrPhone,
        fullName,
        password,
        referalCode,
        isObscure,
        isEmailValid,
        isProfileValid,
        isLoading
      ];

  SignUpFormState copyWith({
    String? emailOrPhone,
    String? fullName,
    String? password,
    String? referalCode,
    bool? isObscure,
    bool? isEmailValid,
    bool? isProfileValid,
    bool? isLoading,
  }) {
    return SignUpFormState(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      referalCode: referalCode ?? this.referalCode,
      isObscure: isObscure ?? this.isObscure,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isProfileValid: isProfileValid ?? this.isProfileValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
