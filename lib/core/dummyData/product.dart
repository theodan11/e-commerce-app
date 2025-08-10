class Product {
  final String title;
  final double price;
  final String img;
  final double rating;
  final int numOfReviews;
  final bool isDiscount;
  final double prevOriginalPrice;

  Product({
    required this.title,
    required this.price,
    required this.img,
    this.rating = 0,
    this.numOfReviews = 0,
    this.isDiscount = false,
    this.prevOriginalPrice = 0,
  });
}
