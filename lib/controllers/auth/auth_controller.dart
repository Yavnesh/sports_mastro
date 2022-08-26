import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/screens/login_register/login_screen.dart';
import 'package:sports_gurukul/screens/onboarding/onboarding_screen.dart';
import 'package:sports_gurukul/widgets/bottom_navigation/bottom_navigation.dart';
import '../../models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;

  late Rx<UserModel> userDB;

  // RxBool isLoggedIn = false.obs;
  // String usersCollection = "users";
  // Rx<UserModel> userModel = UserModel(user_id, display_name, email, last_signed_in, created_on, is_new_user) as Rx<UserModel>;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => BottomNavigation(email: user.email!));
    }
  }

  void signIn(email, password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => print('${value} - signin    ////******'));
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("SignIn Failed", e.toString());
    }
  }

  void signUp(username, email, password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        final userModel = UserModel(
            value.user!.uid,
            username,
            value.user!.email,
            value.user!.metadata.lastSignInTime.toString(),
            value.user!.metadata.creationTime.toString(),
            value.additionalUserInfo!.isNewUser);

        await addUser(userModel);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("SignUp Failed", e.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  addUser(UserModel userModel) async {
    await firebaseFirestore.collection('users').doc(userModel.user_id).set({
      'display_name': userModel.display_name,
      'id': userModel.user_id,
      'email': userModel.email,
      'last_signed_in': userModel.last_signed_in,
      'created_on': userModel.created_on,
      'is_new_user': userModel.is_new_user,
    });
  }
}
