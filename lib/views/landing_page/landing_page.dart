import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/homepage/HomePage.dart';
import '../auth_pages/new_auth_pages/logIn_Screen.dart';
import '../auth_pages/new_auth_pages/signUpForm_Screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  // avoid multiple navigation in animation
  bool _isNavigating = false;
  late AnimationController _tapController;
  late Animation<Offset> _tapAnimation;
  String? _pageType;

  @override
  void initState() {
    super.initState();

    // Tap Animation
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _tapAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeInOut,
    ));

    // Adding a listener
    _tapController.addListener(() {
      if (_tapController.value >= 0.450 && !_isNavigating) {
        _isNavigating = true;
        // Navigate based on the page type stored in _pageType
        if (_pageType == "Guest") {
          Get.to(() => const HomePage(),
                  routeName: '/home', transition: Transition.rightToLeft)
              ?.then((value) {
            // Reset the animation and flag when coming back
            _tapController.reset();
            _isNavigating = false;
          });
        } else if (_pageType == "LogIn") {

          Get.to(() => const LoginScreen(), transition: Transition.rightToLeft)
              ?.then((value) {
            _tapController.reset();
            _isNavigating = false;
          });
        } else {
          Get.to(() => const SignupScreen(), transition: Transition.rightToLeft)
              ?.then((value) {
            _tapController.reset();
            _isNavigating = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  // Handle tap animation and store the page type for navigation
  void _handleTap(String pageType) {
    _pageType = pageType;
    _tapController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        child: Center(child: Image.asset("assets/logos/landingImg.png")),
                      ),
                      Positioned(
                        top: height(context: context, value: 0.15),
                        left: 0,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _tapAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: _tapAnimation.value *
                                  MediaQuery.of(context).size.width,
                              child: child,
                            );
                          },
                          child: Lottie.asset("assets/images/animation.json"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context: context, value: 0.01)),
                  styleText(
                    text: "Discover Affordable",
                    txtColor: Colors.grey.shade700,
                    weight: FontWeight.w500,
                    size: 20.sp,
                  ),
                  styleText(
                    text: "Rental Rides",
                    txtColor: Colors.grey.shade700,
                    weight: FontWeight.w500,
                    size: 20.sp,
                  ),
                  SizedBox(height: height(context: context, value: 0.03)),
                  styleText(
                    text: "Get, Set , Go!",
                    txtColor: Colors.grey.shade700,
                    weight: FontWeight.w500,
                    size: 16.5.sp,
                  ),
                  SizedBox(height: height(context: context, value: 0.08)),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: SizedBox(
                      height: height(context: context, value: 0.08),
                      width: width(context: context, value: 0.7),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _handleTap("LogIn");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: darkBlue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                ),
                                child: Center(
                                  child: styleText(
                                    size: textSize(value: 16.sp),
                                    text: "Sign in",
                                    weight: FontWeight.w600,
                                    txtColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _handleTap("Register");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: btnColorTwo,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.r),
                                    bottomRight: Radius.circular(8.r),
                                  ),
                                ),
                                child: Center(
                                  child: styleText(
                                    size: textSize(value: 16.sp),
                                    text: "Register",
                                    weight: FontWeight.w600,
                                    txtColor: txtGreyShade,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height(context: context, value: 0.02)),
                  GestureDetector(
                    onTap: () {
                      Get.find<UserFormController>().isGuest.value = true;
                      _handleTap("Guest");
                      Get.find<GlobalUserController>().setGuestMode();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Guest ',
                        style: GoogleFonts.poppins(
                            fontSize: textSize(value: 16.sp),
                            color: Colors.grey.shade700),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: darkBlue)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          child: Image.asset("assets/logos/landingImg.png"),
                        ),
                        Positioned(
                          top: height(context: context, value: 0.3),
                          left: 0,
                          right: 0,
                          child: AnimatedBuilder(
                            animation: _tapAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: _tapAnimation.value *
                                    MediaQuery.of(context).size.width,
                                child: child,
                              );
                            },
                            child: Lottie.asset("assets/images/animation.json"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context: context, value: 0.01)),
                    styleText(
                      text: "Discover Affordable",
                      txtColor: Colors.grey.shade700,
                      weight: FontWeight.w500,
                      size: 16.sp,
                    ),
                    styleText(
                      text: "Rental Rides",
                      txtColor: Colors.grey.shade700,
                      weight: FontWeight.w500,
                      size: 16.sp,
                    ),
                    SizedBox(height: height(context: context, value: 0.03)),
                    styleText(
                      text: "Get, Set , Go!",
                      txtColor: Colors.grey.shade700,
                      weight: FontWeight.w500,
                      size: 12.sp,
                    ),
                    SizedBox(height: height(context: context, value: 0.08)),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SizedBox(
                        height: height(context: context, value: 0.15),
                        width: width(context: context, value: 0.4),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _handleTap("LogIn");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: darkBlue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      bottomLeft: Radius.circular(8.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: styleText(
                                      size: textSize(value: 4.sp),
                                      text: "Sign in",
                                      weight: FontWeight.w600,
                                      txtColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _handleTap("Register");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: btnColorTwo,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.r),
                                      bottomRight: Radius.circular(8.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: styleText(
                                      size: textSize(value: 4.sp),
                                      text: "Register",
                                      weight: FontWeight.w600,
                                      txtColor: txtGreyShade,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height(context: context, value: 0.02)),
                    GestureDetector(
                      onTap: () {
                        Get.find<UserFormController>().isGuest.value = true;
                        _handleTap("Guest");
                        Get.find<GlobalUserController>().setGuestMode();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Guest ',
                          style: GoogleFonts.poppins(
                              fontSize: textSize(value: 4.sp),
                              color: Colors.grey.shade700),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: darkBlue)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}
