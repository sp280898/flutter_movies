import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = Get.put(SplashServices());

  @override
  void initState() {
    super.initState();
    splashServices.islogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
            fit: BoxFit.fill, image: AssetImage('lib/assets/images/final.gif')),
      ),
    );
  }
}
