import 'package:equatable/equatable.dart';

class UserUpdateState extends Equatable {
  final String imagePath;
  final String fullname;
  final String error;
  final bool isLoading;
  final bool isSuccess;
  const UserUpdateState(
      {required this.imagePath,
      required this.fullname,
      this.error = '',
      this.isLoading = false,
      this.isSuccess = false});

  factory UserUpdateState.fromJSON(Map<String, dynamic> json) {
    return UserUpdateState(
        imagePath: json['imagePath'], fullname: json['fullname']);
  }

  UserUpdateState copyWith({
    String? imagePath,
    String? fullname,
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return UserUpdateState(
      imagePath: imagePath ?? this.imagePath,
      fullname: fullname ?? this.fullname,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [imagePath, fullname, isLoading, isSuccess, error];
}
