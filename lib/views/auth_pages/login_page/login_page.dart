import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
                    text: "Welcome Back !",
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
                            color: headingColorText)),
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
                    cursorColor: newtestColor,
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
                    obscureText: true,
                    cursorColor: newtestColor,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: headingColorText,
                      ),
                      hintText: "Enter your password",
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
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    styleText(
                        text: "Forgot Password ?",
                        txtColor: txtGreyShade,
                        size: 18.sp),
                  ],
                ),
              ),
              Card(
                elevation: 1,
                child: Container(
                  height: height(context: context, value: 0.063),
                  width: width(context: context, value: 0.9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: testColor.withOpacity(0.5),
                        spreadRadius: -25, // How much the shadow spreads
                        blurRadius: 10, // Softness of the shadow
                        offset: const Offset(-5, 27),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(headingColorText),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                          )),
                      onPressed: () {},
                      child: styleText(
                          text: "Sign in",
                          txtColor: Colors.white,
                          size: textSize(value: 15.sp),
                          weight: FontWeight.w500)),
                ),
              ),
              SizedBox(
                height: height(context: context, value: 0.05),
              ),
              Row(
                children: [
                  Expanded(child: Image.asset("assets/logos/rowOne.png")),
                  styleText(
                      text: "Or Continue With",
                      txtColor: txtGreyShade,
                      size: 15.sp),
                  Expanded(child: Image.asset("assets/logos/rowTwo.png")),
                ],
              ),
              SizedBox(
                height: height(context: context, value: 0.05),
              ),
              Container(
                height: height(context: context, value: 0.06),
                width: width(context: context, value: 0.45),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: Image.asset(
                  "assets/logos/google.png",
                  scale: 11,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
