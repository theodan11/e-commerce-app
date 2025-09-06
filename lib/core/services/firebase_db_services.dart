import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/repository/database_action_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDbServices implements DatabaseActionRepository {
  @override
  Future<void>? saveUserToDB(UserCredential userCred, String fullname) async {
    var db = FirebaseFirestore.instance.collection("users");

    await db.doc(userCred.user!.uid).set({
      "email": userCred.user!.email,
      "fullname": fullname,
    });
  }

  @override
  Future<void>? saveNewsToCloud(
    String? title,
    String? desc,
    String? imagePath,
  ) async {
    var db = FirebaseFirestore.instance.collection("news");

    await db.add({
      "userID": FirebaseAuth.instance.currentUser!.uid,
      "imagePath": imagePath,
      "title": title,
      "desc": desc,
      "addedAt": FieldValue.serverTimestamp()
    });
  }

  @override
  Future<void>? saveProductToCloud(String? title, String? imagePath,
      double? price, int? stock, String? desc) async {
    try {
      var db = FirebaseFirestore.instance.collection("products");

      var storesnapShot =
          await FirebaseFirestore.instance.collection("store").get();

      var storeId = storesnapShot.docs
          .firstWhere((doc) =>
              doc.data()['storeOwner'] ==
              FirebaseAuth.instance.currentUser!.uid)
          .id;

      await db.add({
        "storeId": storeId,
        "name": title,
        "imagePath": imagePath,
        "price": price ?? 0.0,
        "stock": stock ?? 0,
        "desc": desc,
        "reviews": [],
        "addedAt": FieldValue.serverTimestamp()
      });
    } on FirebaseException catch (e) {
      throw Exception("Something went wrong while adding product $e");
    }
  }

  @override
  Future<void>? addWishList(String userId, String productId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("wishList")
        .doc(productId)
        .set({});
  }

  @override
  Future<List<Map<String, dynamic>>> fetchWishList() async {
    List<Map<String, dynamic>> wishList = [];
    try {
      var auth = FirebaseAuth.instance.currentUser!.uid;
      var wishListSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(auth)
          .collection("wishList")
          .get();

      for (var doc in wishListSnapshot.docs) {
        var productSnapshot = await FirebaseFirestore.instance
            .collection("products")
            .doc(doc.id)
            .get();
        if (productSnapshot.exists) {
          var productData = productSnapshot.data()!;
          productData['id'] = productSnapshot.id;
          wishList.add(productData);
        }
      }

      return wishList;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void>? deleteWishList(String userId, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("wishList")
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}
