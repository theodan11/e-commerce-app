class ProductModel {
  final String id;
  final String imagePath;
  final String title;
  final double price;
  final dynamic stock;
  final String storeId;
  final String desc;
  final List<dynamic> reviews;
  final bool isDiscount;
  final double originalPrice;

  const ProductModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.stock,
    required this.storeId,
    required this.desc,
    required this.reviews,
    this.isDiscount = false,
    this.originalPrice = 0,
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      title: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      imagePath: json['imagePath'] ?? '',
      stock: json['stock'],
      // stock: int.parse(json['stock']),
      storeId: json['storeId'] as String ?? '',
      desc: json['desc'] ?? '',
      reviews: (json['reviews'] ?? []) as List<dynamic>,
      isDiscount: json['isDiscount'] ?? false,
      originalPrice: (json['originalPrice'] != null)
          ? double.parse(json['originalPrice'])
          : 0.0,
    );
  }
}
