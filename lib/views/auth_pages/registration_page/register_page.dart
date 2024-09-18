import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/login_page/login_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVisible = true;
  bool isVisibleCPass=true;
  //visibility
  void toggleVisibility() {
    setState(() {
      isVisible=!isVisible;
    });
  }

  //visibility
  void toggleVisibilityTwo() {
    setState(() {
      isVisibleCPass=!isVisibleCPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserFormController>(
        builder: (ctrl) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Lottie.asset("assets/images/second.json",
                      height: 180.h, repeat: false),
                  Center(
                    child: styleText(
                        text: "Register Yourself !",
                        size: textSize(value: 26),
                        txtColor: txtGreyShade),
                  ),
                  Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Super ",
                          style: GoogleFonts.poppins(
                              fontSize: textSize(value: 18),
                              color: Colors.grey.shade700),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Rider',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: greenTextColor)),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: height(context: context, value: 0.03),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 2,
                    child: Container(
                      height: height(context: context, value: 0.48),
                      width: width(context: context, value: 0.9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.grey.shade200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              elevation: 1,
                              child: Container(
                                height: height(context: context, value: 0.067),
                                width: width(context: context, value: 0.9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius:
                                      -22, // How much the shadow spreads
                                      blurRadius: 10, // Softness of the shadow
                                      offset: const Offset(-5, 28),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: ctrl.email,
                                  cursorColor: greenTextColor,
                                  decoration: InputDecoration(
                                    hintText: "Enter your email",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp, color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: txtGreyShade, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: greenTextColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context: context, value: 0.03),
                            ),

                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              elevation: 1,
                              // Set Card elevation to 0 to avoid conflicting shadows
                              child: Container(
                                height: height(context: context, value: 0.067),
                                width: width(context: context, value: 0.9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: -22,
                                      // How much the shadow spreads
                                      blurRadius: 10,
                                      // Softness of the shadow
                                      offset: const Offset(-5, 28),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: ctrl.password,
                                  obscureText: isVisible,
                                  cursorColor: greenTextColor,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          toggleVisibility();
                                        },
                                        icon: isVisible
                                            ? Icon(
                                          Icons.visibility_off,
                                          color: greenTextColor,
                                        )
                                            : Icon(
                                          Icons.visibility,
                                          color: greenTextColor,
                                        )),
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp, color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: txtGreyShade, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: greenTextColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context: context, value: 0.03),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              elevation: 1,
                              // Set Card elevation to 0 to avoid conflicting shadows
                              child: Container(
                                height: height(context: context, value: 0.067),
                                width: width(context: context, value: 0.9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: -22,
                                      // How much the shadow spreads
                                      blurRadius: 10,
                                      // Softness of the shadow
                                      offset: const Offset(-5, 28),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: ctrl.confirmPassword,
                                  obscureText: isVisibleCPass,
                                  cursorColor: greenTextColor,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          toggleVisibilityTwo();
                                        },
                                        icon: isVisibleCPass
                                            ? Icon(
                                          Icons.visibility_off,
                                          color: greenTextColor,
                                        )
                                            : Icon(
                                          Icons.visibility,
                                          color: greenTextColor,
                                        )),
                                    hintText: "Confirm password",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp, color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: txtGreyShade, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: greenTextColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context: context, value: 0.03),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                height: height(context: context, value: 0.063),
                                width: width(context: context, value: 0.9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: greenTextColor.withOpacity(0.5),
                                      spreadRadius:
                                      -25, // How much the shadow spreads
                                      blurRadius: 10, // Softness of the shadow
                                      offset: const Offset(-5, 27),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            greenTextColor),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0.r),
                                          ),
                                        )),
                                    onPressed: () {
                                      ctrl.registrationValidations();

                                    },
                                    child: styleText(
                                        text: "Sign up",
                                        txtColor: Colors.white,
                                        size: textSize(value: 15.sp),
                                        weight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context: context, value: 0.001),
                  ),
                  SizedBox(height: height(context: context, value: 0.02)),
                  styleText(
                      text: "Have an account?",
                      txtColor: txtGreyShade,
                      size: 16.sp),
                  GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.to((const LogInPage()),
                            transition: Transition.rightToLeft);
                      },
                      child: styleText(
                          text: "Login here!",
                          txtColor: greenTextColor,
                          weight: FontWeight.w600,
                          size: 18.sp)),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery
                            .of(context)
                            .size
                            .width * 0.06),
                    child: StepProgressIndicator(
                      roundedEdges: Radius.circular(20.r),
                      totalSteps: 2,
                      currentStep: 2,
                      selectedColor: greenTextColor,
                      unselectedColor: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
