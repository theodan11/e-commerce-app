class ProductModel {
  final String id;
  final String imagePath;
  final String title;
  final double price;
  final int stock;
  // final String vendorID;
  final String desc;

  const ProductModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.stock,
    // required this.vendorID,
    required this.desc,
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      title: json['name'],
      price: json['price'] as double,
      imagePath: json['imagePath'],
      stock: json['stock'] as int,
      // vendorID: json['vendorID'],
      desc: json['desc'],
    );
  }
}
