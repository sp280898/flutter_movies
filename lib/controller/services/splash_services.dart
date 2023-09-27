//

import 'dart:async';

import 'package:get/get.dart';

import '../../routes/routes_name.dart';
import '../../data/user_prefernce/user_preferences.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void islogin() {
    //
    userPreference.alreadyLogin().then((value) {
      if (value == true) {
        Timer(const Duration(seconds: 5),
            () => Get.offAllNamed(RoutesName.homeView));
      } else {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RoutesName.loginView));
      }
    });
  }
}
