import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/login_page/login_page.dart';

class SendOTPScreen extends StatefulWidget {
  const SendOTPScreen({super.key});

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserFormController>(
        autoRemove: false,
        assignId: true,
        builder: (ctrl) {
          return GestureDetector(
            onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
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
                          child: Lottie.asset(
                              "assets/images/resetPassword.json",
                              repeat: false,
                              height: 120.h)),
                      SizedBox(
                        height: height(context: context, value: 0.03),
                      ),
                      styleText(text: "Forgot Password?",txtColor: Colors.black,weight: FontWeight.w500),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: styleText(text: "No worries we will assist you.",size:15.sp,txtColor: txtGreyShade),
                      ),
                      SizedBox(
                        height: height(context: context, value: 0.03),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          styleText(text: "Email",txtColor: txtGreyShade,size: 15.sp,weight: FontWeight.w500),
                          Container(
                            height:height(context: context, value: 0.063),
                            width: width(context: context, value: 0.9),
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: TextFormField(
                              keyboardType:TextInputType.emailAddress,
                              controller: ctrl.resetEmail,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.h),
                                hintText: "Enter your email",
                                hintStyle: GoogleFonts.poppins(),
                                enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: greenTextColor,
                                  ),
                                    borderRadius: BorderRadius.circular(15.r),
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                      Card(
                        elevation: 1,
                        child: Container(
                          height:
                          height(context: context, value: 0.06),
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
                              onPressed: () async{
                                FocusManager.instance.primaryFocus
                                    ?.unfocus();
                                await Get.find<UserFormController>().sendOTP();
                              },
                              child: styleText(
                                  text:
                                  "Send OTP",
                                  txtColor: Colors.white,
                                  size: textSize(value: 15.sp),
                                  weight: FontWeight.w500)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                        Get.off(()=>const LogInPage(),transition: Transition.rightToLeft);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back,color:txtGreyShade),
                              styleText(text: "Back to log in",txtColor: txtGreyShade,size: 15.sp)
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
