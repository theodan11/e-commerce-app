import 'package:e_commerce_app/core/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthRepository {
  var auth = FirebaseAuth.instance;
  @override
  Future<UserCredential>? signUP(String email, String password) async {
    var auth = FirebaseAuth.instance;

    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserCredential>? signIn(String email, String password) async {
    try {
      UserCredential userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
