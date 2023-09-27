import 'package:flutter/material.dart';
import 'package:flutter_movies/data/user_prefernce/user_preferences.dart';
import 'package:flutter_movies/resources/colors/app_colors.dart';
import 'package:flutter_movies/routes/routes_name.dart';

import 'package:get/get.dart';
import '../../resources/components/roun_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isVisible = true;
  bool isLogin = false;

  UserPreference userPreference = UserPreference();

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "name can't be empty";
                      } else {
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        // hintText: 'login',
                        label: const Text('name or Email Id'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    obscureText: isVisible,
                    controller: passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: !isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        label: const Text('Password'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Obx(() =>
          RoundButton(
            title: 'Login',
            onPress: () async {
              if (_formkey.currentState!.validate()) {
                userPreference
                    .verifyUser(emailController.text, emailController.text,
                        passController.text)
                    .then((value) {
                  setState(() {
                    isLogin = true;
                  });
                  userPreference.saveLogin(isLogin);
                });
              }
            },
            height: 50,
            width: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account"),
              TextButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.signUpView);
                  },
                  child: const Text('Signup Here'))
            ],
          ),
        ],
      ),
    );
  }
}
