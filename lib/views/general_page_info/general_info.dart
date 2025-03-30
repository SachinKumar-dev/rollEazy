import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: styleText(text: "General Info", txtColor: Colors.black,weight: FontWeight.w500),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:  Icon(Icons.arrow_back_ios_rounded,color: darkBlue,),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  styleText(
                      text: "Welcome to Roll Eazy!",
                      txtColor: darkBlue,
                      weight: FontWeight.bold),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: generalInfo(
                        text:
                            "Where rolling is easy, affordable, and convenient.",
                        weight: FontWeight.normal,
                        txtSize: 15,
                        maxLines: 2),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text: "Highlights of the App",
                  weight: FontWeight.bold,
                  txtSize: 17,
                  color: darkBlue),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text:
                      "* Search Made Simple: Easily browse through available vehicles tailored to your needs.",
                  weight: FontWeight.normal,
                  txtSize: 15,
                  maxLines: 3,
                  alignment: TextAlign.start),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text:
                      "* Transparent Transactions: Check refunds and ride history at your fingertips.",
                  weight: FontWeight.normal,
                  txtSize: 15,
                  maxLines: 3,
                  alignment: TextAlign.start),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text:
                      "* Enquiry System: Effortlessly enquire about vehicle and related details directly from owner.",
                  weight: FontWeight.normal,
                  txtSize: 15,
                  alignment: TextAlign.start,
                  maxLines: 3),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text:
                      "* Per Vehicle Review: Effortlessly check vehicle reviews before booking.",
                  weight: FontWeight.normal,
                  txtSize: 15,
                  alignment: TextAlign.start,
                  maxLines: 3),
              SizedBox(
                height: 20.h,
              ),
              styleText(
                  text: "🚀 Coming Soon",
                  size: 17,
                  txtColor: darkBlue,
                  weight: FontWeight.bold),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text:
                      "This is an early version of the application. Exciting new features are on the way to make the ride-booking system even more user-friendly, automated, and hassle-free.",
                  weight: FontWeight.normal,
                  txtSize: 15,
                  maxLines: 10,
                  alignment: TextAlign.center),
              SizedBox(
                height: 10.h,
              ),
              generalInfo(
                  text: "So stay tuned!",
                  weight: FontWeight.bold,
                  txtSize: 17,
                  color: darkBlue)
            ],
          ),
        ),
      ),
    );
  }
}

Widget generalInfo(
    {required String text,
    int maxLines = 1,
    required FontWeight weight,
    required double txtSize,
    Color color = Colors.black,
    TextAlign alignment = TextAlign.center}) {
  return Text(
    text,
    textAlign: alignment,
    style: GoogleFonts.poppins(
        fontSize: txtSize.sp,
        fontWeight: weight,
        color: color,
        textStyle: const TextStyle(overflow: TextOverflow.ellipsis)),
    maxLines: maxLines,
  );
}
