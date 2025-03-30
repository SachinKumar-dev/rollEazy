import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../../utility/color_helper/color_helper.dart';
import '../../../utility/widget_helper/widget_helper.dart';

class RegistrationEmailVerification extends StatefulWidget {
  const RegistrationEmailVerification({super.key});

  @override
  State<RegistrationEmailVerification> createState() =>
      _RegistrationEmailVerificationState();
}

class _RegistrationEmailVerificationState
    extends State<RegistrationEmailVerification> {
  bool isVisible = false;
  bool otpSent = false;
  int countdown = 2;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdown = 120;
    setState(() {
      otpSent = true;
    });

    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          otpSent = false;
        });
        _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (isSuccess, result) {
        if (isSuccess) {
          Get.find<UserFormController>().otpSent.value=false;
        } else {
          //print('Pop action failed or canceled.');
        }
      },
      child: Scaffold(
        body: GetBuilder<UserFormController>(
          autoRemove: false,
          assignId: true,
          builder: (ctrl) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height(context: context, value: 0.07),
                        ),
                        Center(
                            child: Lottie.asset("assets/images/authOtp.json",
                                repeat: false, height: 120.h)),
                        SizedBox(
                          height: height(context: context, value: 0.03),
                        ),
                        styleText(
                            text: "Let's get verified!",
                            txtColor: Colors.black,
                            weight: FontWeight.w500),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: styleText(
                              text: " No worries we will assist you.",
                              size: 15.sp,
                              txtColor: txtGreyShade),
                        ),
                        SizedBox(
                          height: height(context: context, value: 0.03),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              styleText(
                                  text: "Email",
                                  txtColor: darkBlue,
                                  size: 15.sp,
                                  weight: FontWeight.w500),
                              Container(
                                height: height(context: context, value: 0.063),
                                width: width(context: context, value: 0.9),
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                child: TextFormField(
                                  cursorColor: darkBlue,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: ctrl.verifyRegistrationEmail,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.h),
                                      hintText: "Enter your email",
                                      hintStyle: GoogleFonts.poppins(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide:
                                              BorderSide(color: lightBlue)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: darkBlue,
                                        ),
                                        borderRadius: BorderRadius.circular(10.r),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: height(context: context, value: 0.02)),
                            child: OtpTextField(
                              clearText: true,
                              alignment: Alignment.center,
                              cursorColor: darkBlue,
                              enabledBorderColor: lightBlue,
                              contentPadding: EdgeInsets.all(10.h),
                              numberOfFields: 4,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 60.h,
                              focusedBorderColor: darkBlue,
                              showFieldAsBox: true,
                              fieldWidth: 72.w,
                              textStyle:
                                  TextStyle(fontSize: 20.sp, color: Colors.black),
                              onSubmit: (String verificationCode) async {
                                ctrl.registrationOTP.text = verificationCode;
                                await ctrl.verifyBeforeRegistration();
                              },
                            ),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: Container(
                            height: height(context: context, value: 0.06),
                            width: width(context: context, value: 0.9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: darkBlue.withOpacity(0.5),
                                  spreadRadius: -25,
                                  blurRadius: 10,
                                  offset: const Offset(-5, 27),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Get.find<UserFormController>().otpSent.value ? Colors.grey : darkBlue,
                                    ),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0.r),
                                      ),
                                    )),
                                onPressed: Get.find<UserFormController>().otpSent.value
                                    ? null
                                    : () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  bool isSent = await Get.find<UserFormController>().sendRegistrationOTP('');
                                  if (isSent) {
                                    setState(() {
                                      isVisible = true;
                                      startCountdown();
                                    });
                                  }
                                },
                                child: styleText(
                                    text: "Send OTP",
                                    txtColor: Colors.white,
                                    size: textSize(value: 15.sp),
                                    weight: FontWeight.w500)),
                          ),
                        ),
                        GestureDetector(
                          onTap: !otpSent && countdown == 0
                              ? () {
                                  Get.find<UserFormController>().resendOtpOne();
                                }
                              : null,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 30.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (otpSent && countdown > 0)
                                  styleText(
                                      text:
                                          "You can resend the OTP in $countdown seconds",
                                      txtColor: darkBlue,
                                      size: 16.sp,
                                      weight: FontWeight.w500)
                                else if (!otpSent && countdown == 0)
                                  styleText(
                                      text: "Resend OTP",
                                      txtColor: darkBlue,
                                      size: 18.sp,
                                      weight: FontWeight.w500),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
