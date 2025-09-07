import 'package:equatable/equatable.dart';

class ReviewCreateState extends Equatable {
  final int? rating;
  final String? customerExperience;
  final bool isLoading;
  final bool isSuccess;

  const ReviewCreateState({
    this.rating = 0,
    this.customerExperience = '',
    this.isSuccess = false,
    this.isLoading = false,
  });

  ReviewCreateState copyWith({
    int? rating,
    String? customerExperience,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ReviewCreateState(
      rating: rating ?? this.rating,
      customerExperience: customerExperience ?? this.customerExperience,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [rating, customerExperience, isLoading, isSuccess];
}
