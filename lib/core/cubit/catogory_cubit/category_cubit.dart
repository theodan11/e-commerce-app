import 'package:e_commerce_app/core/cubit/catogory_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState(category: ''));

  void updateCategory(String category) {
    emit(state.copyWith(category: category));
  }
}
