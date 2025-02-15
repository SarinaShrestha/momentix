import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/model/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, UserModel user) async{
    try {
    await _db.collection('Users').doc(uid).set(user.toJson()).whenComplete(
      () => Get.snackbar("Success", "The account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        animationDuration: Duration(milliseconds: 200),
      ));
    } catch(error) {
      Get.snackbar("Error", "An error occurred while creating the account.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        animationDuration: Duration(milliseconds: 200),
      );
    }
  }
}