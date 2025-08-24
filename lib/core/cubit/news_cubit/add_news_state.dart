import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AddNewsState extends Equatable {
  final String? title;
  final String? desc;
  final String? imagePath;
  final Uint8List? imageByte;
  final bool isLoading;
  final bool isSuccess;

  const AddNewsState({
    this.title = '',
    this.desc = '',
    this.imagePath = '',
    this.imageByte,
    this.isLoading = false,
    this.isSuccess = false,
  });

  AddNewsState copyWith({
    String? title,
    String? desc,
    String? imagePath,
    Uint8List? imageByte,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return AddNewsState(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      imagePath: imagePath ?? this.imagePath,
      imageByte: imageByte ?? this.imageByte,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        title,
        desc,
        imagePath,
        imagePath,
        isLoading,
        isSuccess,
      ];
}
