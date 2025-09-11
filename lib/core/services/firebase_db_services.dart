import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/repository/database_action_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseDbServices implements DatabaseActionRepository {
  @override
  Future<void>? saveUserToDB(UserCredential userCred, String fullname) async {
    var db = FirebaseFirestore.instance.collection("users");

    await db.doc(userCred.user!.uid).set({
      "email": userCred.user!.email,
      "fullname": fullname,
      "imagePath": '',
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
  Future<void>? saveProductToCloud({
    String? title,
    String? imagePath,
    double? price,
    double? originalPrice = 0.0,
    bool? isDiscount = false,
    int? stock,
    String? desc,
  }) async {
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
        "originalPrice": originalPrice,
        "isDiscount": isDiscount,
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

  @override
  Future<Map<String, dynamic>>? fetchSingleNews(String newsId) async {
    try {
      var result =
          await FirebaseFirestore.instance.collection("news").doc(newsId).get();
      if (result.exists) {
        Map<String, dynamic> newsItem = result.data() as Map<String, dynamic>;
        return newsItem;
      } else {
        return {};
      }
    } on FirebaseException catch (e) {
      throw Exception("Something went wrong while fetching news. ${e.message}");
    }
  }

  @override
  Future<dynamic> fetchOwnerStore() async {
    try {
      QuerySnapshot storeSnapshot = await FirebaseFirestore.instance
          .collection("store")
          .where('storeOwner',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // print(storeSnapshot);

      Map<String, dynamic> storeInfo = storeSnapshot.docs.map((doc) {
        if (doc['storeOwner'] == FirebaseAuth.instance.currentUser!.uid) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }
      }) as Map<String, dynamic>;

      return storeInfo;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<dynamic> fetchProduct(String storeId) async {
    try {
      final productsSnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("storeId", isEqualTo: storeId)
          .get();
      var products = productsSnapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        // print(data['id']);
        return ProductModel.fromJSON(doc.data(), doc.id);
      }).toList();
      return products;
    } on FirebaseException catch (e) {
      // print(e.message);
      return e.message.toString();
    }
  }

  @override
  Future<dynamic> fetchStoreInfo(String storeId) async {
    dynamic storeInfo;
    try {
      DocumentSnapshot storeSnapshot = await FirebaseFirestore.instance
          .collection("store")
          .doc(storeId)
          .get();
      storeInfo = storeSnapshot.data() as Map<String, dynamic>;
      Timestamp createdAt = storeInfo['createdAt'] as Timestamp;
      DateTime date = createdAt.toDate();

      String fomattedDate = DateFormat("MMM dd yyyy").format(date);
      storeInfo['formattedDate'] = fomattedDate;
      var products = await fetchProduct(storeId);
      storeInfo['products'] = products;
      return storeInfo;
    } on FirebaseException catch (e) {
      // print(e.message);
      return e.message.toString();
    }
  }

  @override
  Future<bool> checkIfSeller() async {
    try {
      final user = FirebaseAuth.instance.currentUser!.uid;

      final querySnapshot =
          await FirebaseFirestore.instance.collection("store").get();

      final storeData = querySnapshot.docs.where((item) {
        return item['storeOwner'] == user;
      });

      if (storeData.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      // print(e.message);
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return userData;
    } on FirebaseException catch (e) {
      // print(e.message);
      throw Exception(e.message);
    }
  }
}
