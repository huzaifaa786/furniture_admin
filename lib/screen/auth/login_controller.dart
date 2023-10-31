import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:get/get.dart';

import '../../helper/loading.dart';
import '../../services/auth_service.dart';
import '../../values/Validator.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final _firbaseauth = FirebaseAuth.instance;
  RxBool validateSignInForm = false.obs;

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  //  User firebaseUser = User();
  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> loginUser() async {
    print('i am here');
    print(currentUser);
    LoadingHelper.show();
    final bool isFormValid = Validators.emailValidator(email.text) == null &&
        Validators.emptyStringValidator(password.text, '') == null;

    if (isFormValid) {
      String? error = await authService.loginWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      LoadingHelper.dismiss();
      if (error != null) {
        Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          duration: const Duration(seconds: 3),
        ));
      }
    }
    LoadingHelper.dismiss();
  }

  Future<void> signOut() async {
    await Firebase.initializeApp();
    LoadingHelper.show();
    await _firbaseauth.signOut();
    LoadingHelper.dismiss();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
