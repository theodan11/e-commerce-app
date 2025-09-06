import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseActionRepository {
  Future<void>? saveUserToDB(UserCredential userCred, String fullname);

  Future<void>? saveNewsToCloud(String? title, String? desc, String? imagePath);

  Future<void>? saveProductToCloud(String? title, String? imagePath,
      double? price, int? stock, String? desc);

  Future<void>? addWishList(String userId, String productId);

  Future<List<Map<String, dynamic>>> fetchWishList();

  Future<void>? deleteWishList(String userId, String productId);
}
