import 'package:flutter/material.dart';
import 'package:flutter_movies/data/user_prefernce/user_preferences.dart';
import 'package:flutter_movies/utils/utils.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  UserPreference _userPreference = UserPreference();
  static final nameController = TextEditingController();
  static final mailController = TextEditingController();
  static final phoneController = TextEditingController();
  static final passController = TextEditingController();

  //
  // @override
  // void dispose() {
  //   mailController.dispose();
  //   passController.dispose();
  //   phoneController.dispose();
  //   nameController.dispose();
  //   super.dispose();
  // }

  Future<void> saveUser() async {
    _userPreference
        .saveUser(
      nameController.text,
      mailController.text,
      phoneController.text,
      passController.text,
    )
        .then((value) {
      Utils.snackBar('SignUp Succesfull', 'please login');
      // Utils.taostMessage('Successfully Signed Up');
    });
  }
}
