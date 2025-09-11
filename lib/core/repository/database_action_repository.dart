import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseActionRepository {
  Future<void>? saveUserToDB(UserCredential userCred, String fullname);

  Future<void>? saveNewsToCloud(String? title, String? desc, String? imagePath);

  Future<void>? saveProductToCloud({
    String? title,
    String? imagePath,
    double? price,
    double? originalPrice,
    bool? isDiscount,
    int? stock,
    String? desc,
  });

  Future<void>? addWishList(String userId, String productId);

  Future<List<Map<String, dynamic>>> fetchWishList();

  Future<void>? deleteWishList(String userId, String productId);

  Future<Map<String, dynamic>>? fetchSingleNews(String newsId);

  Future<dynamic> fetchStoreInfo(String storeId);
  Future<dynamic> fetchProduct(String storeId);
  Future<bool> checkIfSeller();
  Future<Map<String, dynamic>> fetchUserData();
  Future<dynamic> fetchOwnerStore();
}
