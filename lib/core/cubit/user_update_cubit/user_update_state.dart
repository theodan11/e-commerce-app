import 'package:equatable/equatable.dart';

class UserUpdateState extends Equatable {
  final String imagePath;
  final String fullname;
  bool isLoading;
  bool isSuccess;
  UserUpdateState(
      {required this.imagePath,
      required this.fullname,
      this.isLoading = false,
      this.isSuccess = false});

  UserUpdateState copyWith({
    String? imagePath = '',
    String? fullname = '',
    bool? isLoading,
    bool? isSuccess,
  }) {
    return UserUpdateState(
      imagePath: imagePath ?? this.imagePath,
      fullname: fullname ?? this.fullname,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [imagePath, fullname, isLoading, isSuccess];
}
