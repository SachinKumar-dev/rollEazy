import 'dart:async';
import 'package:flutter/material.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/landing_page/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LandingPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF387F39),
              Color(0xFF365E32),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Image.asset("assets/logos/splash_logo.png"),
        ),
      ),
    );
  }
}
