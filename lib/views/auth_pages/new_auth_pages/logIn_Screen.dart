import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/new_auth_pages/signUpForm_Screen.dart';
import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../reset_password_page/otp_send_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  //visibility
  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: GetBuilder(builder: (UserFormController ctrl) {
          return Stack(
            children: [
              Image.asset('assets/logos/Ellipse 1.png',fit: BoxFit.cover,
                  scale: MediaQuery.of(context).size.width / 500),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/logos/Ellipse 2.png',fit: BoxFit.cover,
                  scale: MediaQuery.of(context).size.width / 180,
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/logos/Group 3.png',fit: BoxFit.cover,
                    scale: MediaQuery.of(context).size.width / 350,
                  )),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: height(context: context, value: 0.02),
                      left: width(context: context, value: 0.02)),
                  height: height(context: context, value: 0.45),
                  width: width(context: context, value: 0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 10.h, top: 10.h, bottom: 20.h),
                              child: styleText(
                                  text: "LogIn",
                                  txtColor: darkBlue,
                                  weight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.to(() => const SignupScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: darkBlue, width: 2),
                                    borderRadius: BorderRadius.circular(10.r)),
                                margin: EdgeInsets.only(
                                    left: 0.h,
                                    top: 10.h,
                                    bottom: 20.h,
                                    right: 10.w),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: styleText(
                                      size: 16.sp,
                                      text: "SignUp",
                                      txtColor: darkBlue,
                                      weight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: ctrl.logEmail,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.email_rounded, color: darkBlue),
                            hintText: "e-mail address",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue, width: 2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintStyle: const TextStyle(color: Colors.black38),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: ctrl.logPassword,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  toggleVisibility();
                                },
                                icon: isVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: darkBlue,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: darkBlue,
                                      )),
                            prefixIcon:
                                Icon(Icons.lock_rounded, color: darkBlue),
                            hintText: "password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue, width: 2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintStyle: const TextStyle(color: Colors.black38),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      //button for logIn
                      SizedBox(
                        height: 10.h,
                      ),
                      //forgot pass
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.to((const SendOTPScreen()),
                                    transition: Transition.rightToLeft);
                              },
                              child: Text(
                                "Forgot password ?",
                                style: TextStyle(
                                    color: darkBlue,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Card(
                              elevation: 1.2,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5.r),
                                splashColor: darkBlue,
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ctrl.logInValidations();
                                },
                                child: Container(
                                  height: height(context: context, value: 0.04),
                                  width: width(context: context, value: 0.2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            lightBlue,
                                            darkBlue,
                                          ])),
                                  child: Center(
                                      child: styleText(
                                          text: "LogIn",
                                          size: 16.sp,
                                          weight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
