import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/features/core/home/views/home_page.dart';
import 'package:frontend/repository/authentication_repository/exceptions/signup_failure.dart';
import 'package:frontend/features/authentication/views/login/login.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth  = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null? Get.offAll(() => const LoginPage()) : Get.offAll(() => const HomePage());
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;

    }on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      print('Failed to create user: ${ex.message}');
      throw ex;
    } catch (_){
      const ex = SignUpFailure();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('Error creating account', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

}