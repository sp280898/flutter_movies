import 'package:flutter_movies/routes/routes_name.dart';
import 'package:flutter_movies/utils/utils.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<void> saveUser(
    String name,
    String mail,
    String phone,
    String password,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('name', name.toString());
    sp.setString('mail', mail.toString());
    sp.setString('phone', phone.toString());
    sp.setString('password', password.toString());
  }

  //
  Future<void> verifyUser(String? mail, String? name, var password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    //
    if (mail == sp.getString('mail') ||
        name == sp.getString('name') &&
            (password == sp.getString('password'))) {
      // if  {
      Get.offAllNamed(RoutesName.homeView);
      Utils.taostMessage('Login Succesfull');
      // }
    } else {
      Utils.taostMessage('Invalid credentilas');
      Get.snackbar("Invalid name or password", 'Try again');
    }
  }

  void saveLogin(bool isLogin) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLogin', isLogin);
  }

  Future<bool> alreadyLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') == true;
    // Get.off(() => const HomeView());

    return isLogin;
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
