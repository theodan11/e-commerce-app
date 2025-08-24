import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseActionRepository {
  Future<void>? saveUserToDB(UserCredential userCred, String fullname);

  Future<void>? saveNewsToCloud(String? title, String? desc, String? imagePath);
}
