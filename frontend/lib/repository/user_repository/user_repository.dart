import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/model/user_model.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
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

  Future<void> updateUserDetails(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

  Future<UserModel> getUserData(String email) async {
    try{
      final user = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();

      if (user.exists) {
        return UserModel.fromSnapshot(user);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      print('Error: ${e.message}');
    } on FormatException catch (e) {
      print('Error: ${e.message}');
    } catch (e) {
      print('Error: ${e.toString()}');
    }



    final user = await _db.collection('Users').where('email', isEqualTo: email).get();
    final userData = user.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
}