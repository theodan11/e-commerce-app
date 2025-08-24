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

      await db.add({
        "name": title,
        "imagePath": imagePath,
        "price": price,
        "stock": stock,
        "desc": desc,
        "addedAt": FieldValue.serverTimestamp()
      });
    } on FirebaseException catch (e) {
      throw Exception("Something went wrong while adding product $e");
    }
  }
}
