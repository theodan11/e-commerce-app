import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void>? sendOTP(String email) {
  String otpNum = (1000 + Random().nextInt(9999)).toString();

  final expiryTime = DateTime.now().add(const Duration(minutes: 5));

  FirebaseFirestore.instance.collection("otp").doc(email).set({
    "code": otpNum,
    "expiresAt": expiryTime,
  });
}
