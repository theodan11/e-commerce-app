class CategoryState {
  final String category;
  const CategoryState({required this.category});

  CategoryState copyWith({String? category}) {
    return CategoryState(category: category ?? this.category);
  }
}
