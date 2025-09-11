import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final Timestamp createdAt;
  final List<OrderItem> items;
  final String status;
  final double totalPrice;

  const OrderModel(
      {required this.createdAt,
      required this.items,
      required this.orderId,
      required this.status,
      required this.totalPrice});

  factory OrderModel.fromJSON(Map<String, dynamic> json, String orderId) {
    return OrderModel(
        createdAt: json["cretedAt"],
        items: json['items'].map((item) {
          return OrderItem.fromJSON(item);
        }).toList(),
        orderId: json['orderId'],
        status: json['status'],
        totalPrice: json['totalPrice']);
  }
}

class OrderItem {
  final int quantity;
  final double price;
  final Product product;

  const OrderItem(
      {required this.price, required this.product, required this.quantity});

  factory OrderItem.fromJSON(Map<String, dynamic> json) {
    return OrderItem(
        price: json["price"],
        product: Product.fromJSON(json["product"]),
        quantity: json["quantity"]);
  }
}

class Product {
  final String productId;
  final double productPrice;
  final String productTitle;

  const Product(
      {required this.productId,
      required this.productPrice,
      required this.productTitle});

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
        productId: json["productId"],
        productPrice: json["productPrice"],
        productTitle: json["productTitle"]);
  }
}
