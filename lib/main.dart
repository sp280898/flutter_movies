import 'package:flutter/material.dart';

import 'package:flutter_movies/routes/routes.dart';
import 'package:flutter_movies/view/splasha_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
