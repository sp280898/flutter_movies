import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies/resources/colors/app_colors.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_movies/routes/routes_name.dart';
import '../../../resources/components/roun_button.dart';
import '../../controller/signup/signup_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController signUpController = Get.put(SignUpController());
  final _formkey = GlobalKey<FormState>();
  final _dropKey = GlobalKey<FormState>();

  String? currentItem;

  var items = [
    'Engineer',
    'Doctor',
    'Lawyer',
    'Teacher',
  ];

  bool isVisible = true;

  @override
  void initState() {
    // signUpController.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign Up'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Text(
                  //   'Select Your Profession',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  Form(
                    key: _dropKey,
                    child: SizedBox(
                      width: 150,
                      // height: 100,
                      child: DropdownButtonFormField<String>(
                        value: currentItem,
                        hint: const Text('Select Profession'),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Engineer',
                            child: Text('Engineer'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Doctor',
                            child: Text('Doctor'),
                          ),
                          DropdownMenuItem<String>(
                            value: ':Lawyer',
                            child: Text('Lawyer'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Teacher',
                            child: Text('Teacher'),
                          ),
                          // Add more DropdownMenuItem items as needed
                        ],
                        onChanged: (value) {
                          setState(() {
                            currentItem = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        controller: SignUpController.nameController,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'enter full name',
                            label: const Text('Name'),
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
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (isValidEmail(value!)) {
                            return null;
                          } else {
                            return 'Invalid email address';
                          }
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        controller: SignUpController.mailController,
                        decoration: InputDecoration(
                            hintText: 'Enter email id',
                            label: const Text('Email'),
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
                        keyboardType: TextInputType.number,
                        controller: SignUpController.phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.length < 10) {
                            return 'Enter valid mobile number';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            label: const Text('Phone Number'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        obscureText: isVisible,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.visiblePassword,
                        controller: SignUpController.passController,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password Can't be less than 6 digits";
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: !isVisible
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.visibility_off)),
                            hintText: 'password',
                            label: const Text('Password'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              RoundButton(
                title: 'Sign Up',
                onPress: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  if (_formkey.currentState!.validate() &&
                      _dropKey.currentState!.validate()) {
                    signUpController.saveUser().then((value) {
                      sp.setString('profession', currentItem.toString());

                      Get.toNamed(RoutesName.loginView);
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
                  const Text("Already have an account ?"),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(RoutesName.loginView);
                      },
                      child: const Text('SignIn Here'))
                ],
              ),
              // Text()
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegExp.hasMatch(email);
  }
}
