import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/controllers/navigation_ctrl/nav_ctrl.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/views/homepage/dummyHomepage.dart';
import 'package:roll_eazy/views/homepage/home_screen.dart';
import 'package:roll_eazy/views/landing_page/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthService authService = Get.find<AuthService>();
  final GlobalUserController ctrl = Get.find<GlobalUserController>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await authService.isLoggedIn();

    //Navigate based on the login status
    Timer(const Duration(seconds: 1), () {
      if (isLoggedIn) {
        Get.to(() => const DummyHomepage(), transition: Transition.rightToLeft);
      } else {
        Get.to(() => const LandingPage(), transition: Transition.rightToLeft);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/Splash.png", fit: BoxFit.cover);
  }
}
