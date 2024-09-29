import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/views/auth_pages/reset_password_page/otp_send_screen.dart';

import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../../utility/color_helper/color_helper.dart';
import '../../../utility/widget_helper/widget_helper.dart';

class OTPVerificationScreen extends StatefulWidget {
  final email;

  const OTPVerificationScreen({super.key, this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Lottie.asset("assets/images/emailSent.json",
                              repeat: false, height: 100.h)),
                      SizedBox(
                        height: height(context: context, value: 0.03),
                      ),
                      styleText(
                          text: "Reset Password",
                          txtColor: Colors.black,
                          weight: FontWeight.w500),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width(context: context, value: 0.2),
                              top: 10),
                          child: RichText(
                            maxLines: 2,
                            text: TextSpan(
                              text: '  We have sent the otp to ',
                              style: GoogleFonts.poppins(
                                  fontSize: textSize(value: 15.sp),
                                  color: Colors.grey.shade700),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${widget.email}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15.sp,
                                        color: greenTextColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context: context, value: 0.02),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: height(context: context, value: 0.02)),
                        child: OtpTextField(
                          alignment: Alignment.center,
                          cursorColor: greenTextColor,
                          enabledBorderColor: Colors.grey,
                          contentPadding: EdgeInsets.all(10.h),
                          numberOfFields: 4,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 60.h,
                          focusedBorderColor: greenTextColor,
                          showFieldAsBox: true,
                          fieldWidth: 72.w,
                          textStyle:
                              TextStyle(fontSize: 20.sp, color: Colors.black),
                          onSubmit: (String verificationCode) {
                            ctrl.OTP.text = verificationCode;
                            //check if completed filled then only show password and confirm
                            //if not then must ensure to reset pass only if all fields are filled
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            styleText(
                                text: "Password",
                                txtColor: txtGreyShade,
                                size: 15.sp,
                                weight: FontWeight.w500),
                            Container(
                              height: height(context: context, value: 0.063),
                              width: width(context: context, value: 0.9),
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: ctrl.newPassword,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.h),
                                    hintText: "Enter new password",
                                    hintStyle: GoogleFonts.poppins(),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: greenTextColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15.r),
                                    )),
                              ),
                            )
                          ],
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
                                color: greenTextColor.withOpacity(0.5),
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
                                      MaterialStateProperty.all(greenTextColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                    ),
                                  )),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                await Get.find<UserFormController>()
                                    .resetPassword();
                              },
                              child: styleText(
                                  text: "Update Password",
                                  txtColor: Colors.white,
                                  size: textSize(value: 15.sp),
                                  weight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const SendOTPScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back, color: txtGreyShade),
                              styleText(
                                  text: "Resend otp",
                                  txtColor: txtGreyShade,
                                  size: 15.sp)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
