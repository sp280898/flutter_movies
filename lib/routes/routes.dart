import 'package:flutter_movies/routes/routes_name.dart';
import 'package:flutter_movies/view/auth/signup_view.dart';
import 'package:get/get.dart';

import '../view/home/home_view.dart';
import '../view/auth/login_view.dart';
import '../view/splasha_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RoutesName.loginView,
            page: () => const LoginView(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RoutesName.signUpView,
            page: () => const SignUpView(),
            transition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RoutesName.homeView,
            page: () => const HomeView(),
            transition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
      ];
}
