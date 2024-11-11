import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/registration_page/user_form_screen.dart';
import 'package:roll_eazy/views/auth_pages/reset_password_page/otp_send_screen.dart';
import 'controllers/navigation_ctrl/nav_ctrl.dart';

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
        body: GetBuilder(
          builder: (UserFormController ctrl) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade200, Colors.teal.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // Background sphere
                Positioned(
                  left: width(context: context, value: 0.1),
                  top: height(context: context, value: 0.02),
                  child: Container(
                    width: width(context: context, value: 0.5),
                    height: height(context: context, value: 0.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
                // Smaller background elements
                Positioned(
                  left: width(context: context, value: 0.53),
                  bottom: height(context: context, value: 0.14),
                  child: Container(
                    width: width(context: context, value: 0.25),
                    height: height(context: context, value: 0.25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                // Glass card
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.6,
                            child: TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.to(() => const UserFormScreen(),
                                    transition: Transition.rightToLeft);
                              },
                              child: Text('Sign up',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          // Glass Card content
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log in",
                                  style: GoogleFonts.poppins(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.9),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                TextField(
                                  controller: ctrl.logEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_rounded,
                                        color: Colors.black),
                                    hintText: "e-mail address",
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.black26),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15.h),
                                TextField(
                                  controller: ctrl.logPassword,
                                  obscureText: isVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          toggleVisibility();
                                        },
                                        icon: isVisible
                                            ? const Icon(
                                                Icons.visibility_off,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.visibility,
                                                color: Colors.black,
                                              )),
                                    prefixIcon: const Icon(Icons.lock_rounded,
                                        color: Colors.black),
                                    hintText: "password",
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    hintStyle:
                                        const TextStyle(color: Colors.black26),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 30.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Get.to((const SendOTPScreen()),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                        "Forgot password ?",
                                        style: TextStyle(
                                          color:
                                              Colors.black26.withOpacity(0.7),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 1.2,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        splashColor: Colors.green,
                                        onTap: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          ctrl.logInValidations();
                                          await Get.find<AuthService>().login();
                                        },
                                        child: Container(
                                          height: height(
                                              context: context, value: 0.04),
                                          width: width(
                                              context: context, value: 0.2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xff2C8E58),
                                                    Color(0xff75B6BC)
                                                  ])),
                                          child: Center(
                                              child: styleText(text: "LogIn")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
