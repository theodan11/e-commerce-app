import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/news_list_state.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsListCubit extends Cubit<NewsListState> {
  NewsListCubit() : super(const NewsListState(newsList: []));

  Future<void> fetchNewsList() async {
    emit(state.copyWith(isLoading: true));

    try {
      List<NewsModel> nList = [];

      final newsListSnapshot = await FirebaseFirestore.instance
          .collection("news")
          .orderBy("addedAt", descending: true)
          .get();

      nList = newsListSnapshot.docs.map((doc) {
        return NewsModel.fromJSON(doc.data(), doc.id);
      }).toList();
      // print(nList);
      emit(state.copyWith(isLoading: false, isSuccess: true, newsList: nList));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          isLoading: false, isSuccess: false, error: e.message.toString()));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isSuccess: false, error: e.toString()));
    }
  }
}
