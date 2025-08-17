import 'package:equatable/equatable.dart';

class LoginFormState extends Equatable {
  final String emailOrPhone;
  final String password;
  final bool isObscure;
  final bool isSubmitting;
  final bool isSuccess;

  const LoginFormState({
    this.emailOrPhone = '',
    this.password = '',
    this.isObscure = true,
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  LoginFormState copyWith({
    String? emailOrPhone,
    String? password,
    bool? isObscure,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return LoginFormState(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        emailOrPhone,
        password,
        isObscure,
        isSubmitting,
        isSuccess,
      ];

  String? get emailOrPhoneError {
    if (emailOrPhone.isEmpty) return "Email or Phone required";
    return null;
  }

  String? get passwordError {
    if (password.isEmpty) return "Password is required";
    if (password.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  bool get isValid {
    return emailOrPhone.isNotEmpty &&
        password.isNotEmpty &&
        password.length > 6;
  }
}
