import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserFormController>(
        builder: (ctrl) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset("assets/images/second.json",height: 180.h,repeat:false),
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
                    height: height(context: context, value: 0.05),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.067),
                      width: width(context: context, value: 0.9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: -22, // How much the shadow spreads
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
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context: context, value: 0.03),
                  ),
                  txtField(
                      value: ctrl.password,
                      context: context,
                      color: greenTextColor,
                      txt: "Password"),
                  SizedBox(
                    height: height(context: context, value: 0.03),
                  ),
                  txtField(
                      context: context,
                      color: greenTextColor,
                      txt: "Confirm Password"),
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
                            spreadRadius: -25, // How much the shadow spreads
                            blurRadius: 10, // Softness of the shadow
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
                                  borderRadius: BorderRadius.circular(8.0.r),
                                ),
                              )),
                          onPressed: () {
                            ctrl.registerUser();
                          },
                          child: styleText(
                              text: "Sign up",
                              txtColor: Colors.white,
                              size: textSize(value: 15.sp),
                              weight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    height: height(context: context, value: 0.15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.06),
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
