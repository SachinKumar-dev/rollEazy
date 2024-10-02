import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../../utility/color_helper/color_helper.dart';
import '../../../utility/widget_helper/widget_helper.dart';
class RegistrationEmailVerification extends StatefulWidget {
  const RegistrationEmailVerification({super.key});

  @override
  State<RegistrationEmailVerification> createState() => _RegistrationEmailVerificationState();
}

class _RegistrationEmailVerificationState extends State<RegistrationEmailVerification> {

  bool isVisible=false;
  bool otpSent=false;

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
                      styleText(text: "Let's get verified!",txtColor: Colors.black,weight: FontWeight.w500),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: styleText(text: " No worries we will assist you.",size:15.sp,txtColor: txtGreyShade),
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
                                controller: ctrl.verifyRegistrationEmail,
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
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: height(context: context, value: 0.02)),
                          child: OtpTextField(
                            clearText: true,
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
                            onSubmit: (String verificationCode) async{
                              ctrl.registrationOTP.text = verificationCode;
                              await ctrl.verifyBeforeRegistration();

                            },
                          ),
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
                                //need to disable btn once otp sent
                                FocusManager.instance.primaryFocus
                                    ?.unfocus();
                               bool isSent= await Get.find<UserFormController>().sendRegistrationOTP('');
                               if(isSent){
                                 setState(() {
                                   otpSent=true;
                                   isVisible=true;
                                 });
                               }
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
                          Get.find<UserFormController>().resendOtpOne();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              styleText(text: "Resend OTP",txtColor: greenTextColor,size: 18.sp,weight: FontWeight
                              .w500)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height(context: context,value: 0.146)),
                        child: StepProgressIndicator(
                          roundedEdges: Radius.circular(20.r),
                          totalSteps: 3,
                          currentStep: 2,
                          selectedColor: greenTextColor,
                          unselectedColor: Colors.grey,
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
