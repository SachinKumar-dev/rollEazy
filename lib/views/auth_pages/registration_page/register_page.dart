import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/logos/logo_login_rider.png",
                scale: 12,
              ),
              Center(
                child: styleText(
                    text: "Register Yourself",
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
                                fontWeight: FontWeight.w700, color: primaryColor)),
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
                    cursorColor: primaryColor,
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
              txtField(context: context, color: primaryColor, txt: "Password"),
              SizedBox(
                height: height(context: context, value: 0.03),
              ),
             txtField(context: context, color: primaryColor, txt: "Confirm Password"),
              SizedBox(
                height: height(context: context, value: 0.03),
              ),
              Card(
                elevation: 1,
                child: Container(
                  height: height(context: context, value: 0.067),
                  width: width(context: context, value: 0.9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        spreadRadius: -25, // How much the shadow spreads
                        blurRadius: 10, // Softness of the shadow
                        offset: const Offset(-5, 27),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(primaryColor),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          )),
                      onPressed: () {},
                      child: styleText(
                          text: "Sign up",
                          txtColor: Colors.white,
                          size: textSize(value: 18))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
