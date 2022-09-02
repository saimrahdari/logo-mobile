import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logo/constants/firebase.dart';
import 'package:logo/models/user_model.dart';
import 'package:logo/views/pages/first_page.dart';
import 'package:logo/views/pages/menu_page.dart';
import 'package:logo/views/pages/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  Rx<UserModel> userModel = UserModel().obs;
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  //for signin
  TextEditingController semail = TextEditingController();
  TextEditingController spassword = TextEditingController();

  @override
  Future<void> onReady() async {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  @override
  void onClose() {}

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const MenuPage());
    } else {
      Get.offAll(() => const FirstPage());
    }
  }

  void signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {});
    } catch (e) {
      Get.snackbar("Error Signing in", e.toString());
    }
  }

  void signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
            auth.signInWithEmailAndPassword(email: email.text.trim(), password:password.text.trim()).then((value){
              auth.currentUser!.updateDisplayName(userName.text);
              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
                  {
                    'type':'client',
                    'name':FirebaseAuth.instance.currentUser!.displayName,
                    'phone':phone.text,
                    'image':'',
                    'email':email.text,
                  });
            });
      });
    } catch (e) {
      Get.snackbar("Error Signing up", e.toString());
    }
  }

  void updateInfo(name,phone) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'name':name==''?FirebaseAuth.instance.currentUser!.displayName:name,
            'phone':phone==''?FirebaseAuth.instance.currentUser!.phoneNumber:phone,
          }).then((value) {
            print('User name: $name is updated as new.');
      });

    } catch (e) {
      Get.snackbar("Error updating info", e.toString());
    }
  }

  void logout() async {
    auth.signOut();
  }

  _initializeUserModel(String userId) async {}
}
