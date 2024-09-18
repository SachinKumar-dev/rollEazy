import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetBuilder<UserFormController>(
          autoRemove: false,
          assignId: true,
          builder: (ctrl) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height(context: context, value: 0.03),
                      ),
                      Center(
                          child: Lottie.asset(
                              "assets/images/resetPassword.json",
                              repeat: false,
                              height: 180.h)),
                      SizedBox(
                        height: height(context: context, value: 0.03),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        elevation: 2,
                        child: Container(
                          height: isVisible
                              ? height(context: context, value: 0.5)
                              : height(context: context, value: 0.3),
                          width: width(context: context, value: 0.9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.grey.shade200),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                txtFormField(
                                    type: TextInputType.emailAddress,
                                    context: context,
                                    text: "Email",
                                    textType: ctrl.resetEmail),
                                SizedBox(
                                  height: isVisible
                                      ? height(context: context, value: 0.03)
                                      : height(context: context, value: 0.0),
                                ),
                                Visibility(
                                  visible: isVisible,
                                  child: txtFormField(
                                      type: TextInputType.name,
                                      context: context,
                                      text: "OTP",
                                      textType: ctrl.OTP),
                                ),
                                SizedBox(
                                  height: height(context: context, value: 0.03),
                                ),
                                Visibility(
                                  visible: isVisible,
                                  child: txtFormField(
                                      type: TextInputType.name,
                                      context: context,
                                      text: "New Password",
                                      textType: ctrl.newPassword),
                                ),
                                SizedBox(
                                  height: height(context: context, value: 0.03),
                                ),
                                Card(
                                  elevation: 1,
                                  child: Container(
                                    height:
                                        height(context: context, value: 0.063),
                                    width: width(context: context, value: 0.9),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              greenTextColor.withOpacity(0.5),
                                          spreadRadius: -25,
                                          // How much the shadow spreads
                                          blurRadius: 10,
                                          // Softness of the shadow
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
                                                    BorderRadius.circular(
                                                        8.0.r),
                                              ),
                                            )),
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          bool exist =
                                              await ctrl.doesUserExist();
                                          if (exist) {
                                            setState(() {
                                              isVisible = true;
                                            });
                                          }
                                        },
                                        child: styleText(
                                            text: isVisible
                                                ? "Update Password"
                                                : "Verify Email",
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
