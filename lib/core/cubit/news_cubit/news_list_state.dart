import 'package:e_commerce_app/core/cubit/news_cubit/news_model.dart';
import 'package:equatable/equatable.dart';

class NewsListState extends Equatable {
  final List<NewsModel> newsList;
  final String error;
  final bool isLoading;
  final bool isSuccess;

  const NewsListState({
    required this.newsList,
    this.error = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  NewsListState copyWith({
    List<NewsModel>? newsList,
    String? error,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return NewsListState(
        newsList: newsList ?? this.newsList,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,);
  }

  @override
  List<Object?> get props => [newsList, error, isLoading, isSuccess];
}
