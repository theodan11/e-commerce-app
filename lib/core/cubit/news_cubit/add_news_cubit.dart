import 'package:e_commerce_app/core/cubit/news_cubit/add_news_state.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewsCubit extends Cubit<AddNewsState> {
  AddNewsCubit() : super(const AddNewsState());

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDesc(String desc) {
    emit(state.copyWith(desc: desc));
  }

  void updateImagePath(String imagepath) {
    emit(state.copyWith(imagePath: imagepath));
  }

  Future<void> pickImage() async {
    String? imgPath;
    var imgByte;
    Future<void>? pickImg() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result!.files.single.bytes != null) {
        imgPath = result.files.single.path;
        imgByte = result.files.single.bytes;
      }
    }

    await pickImg();
    if (kIsWeb && imgByte != null) {
      emit(state.copyWith(imageByte: imgByte));
    } else if (imgPath != null) {
      emit(state.copyWith(imagePath: imgPath));
    }
  }

  void clearimage() {
    emit(state.copyWith(imagePath: '', imageByte: null));
  }

  void loadingInProgress() {
    emit(state.copyWith(isLoading: true, isSuccess: false));
  }

  void loadingSuccess() {
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  void resetForm() {
    emit(const AddNewsState());
  }
  // Future<void>? uploadToCloud() async {
  //   if (state.title!.isNotEmpty &&
  //       state.desc!.isNotEmpty &&
  //       state.imagePath!.isNotEmpty) {
  //     FirebaseDbServices()
  //         .saveNewsToCloud(state.title, state.desc, state.imagePath);
  //   }
  // }
}
