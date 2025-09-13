import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String imagePath;
  final String title;
  final double price;
  final int stock;
  final String storeId;
  final String desc;
  final String category;
  // final List<ReviewModel>? reviews;
  final List<dynamic>? reviews;
  final bool isDiscount;
  final bool? isFeatured;
  final double originalPrice;

  const ProductModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.stock,
    required this.storeId,
    required this.desc,
    required this.category,
    this.reviews = const [],
    this.isDiscount = false,
    this.isFeatured,
    this.originalPrice = 0.0,
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      title: json['name'],
      price: _toDouble(json['price']),
      stock: _toInt(json['stock']),
      imagePath: json['imagePath'],
      // stock: int.parse(json['stock']),
      storeId: json['storeId'],
      desc: json['desc'],
      category: json['category'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((rev) {
              return ReviewModel.fromJSON(rev);
            }).toList()
          : [],
      isDiscount: json['isDiscount'] ?? false,
      originalPrice: _toDouble(json['originalPrice']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  static int _toInt(dynamic value) {
    if (value == null) {
      return 0;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}

class ReviewModel {
  final Timestamp createdAt;
  final int rating;
  final String review;
  final String userName;
  final String? imagePath;

  const ReviewModel({
    required this.createdAt,
    required this.rating,
    required this.review,
    required this.userName,
    this.imagePath,
  });

  factory ReviewModel.fromJSON(Map<String, dynamic> json) {
    return ReviewModel(
      createdAt: json['createdAt'] as Timestamp,
      rating: _toInt(json['rating']),
      review: json['review'] as String,
      userName: json['userName'] as String,
      imagePath: json['imagePath'] ?? '',
    );
  }
  static int _toInt(dynamic value) {
    if (value == null) {
      return 0;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
