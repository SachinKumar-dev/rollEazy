import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';

//height
double height({required BuildContext context, var value}) {
  var height = MediaQuery.of(context).size.height * value;
  return height;
}

//width
double width({required BuildContext context, var value}) {
  var width = MediaQuery.of(context).size.width * value;
  return width;
}

//padding
//MediaQuery.of(context).size.width * 0.06

//buttonTextSize
double textSize({required double value}) {
  double txtSize = value.sp;
  return txtSize;
}

//text design
Text styleText(
    {required String text,
    double size = 20.0,
    txtColor = Colors.white,
    FontWeight weight = FontWeight.normal}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        fontSize: size, color: txtColor, fontWeight: weight),
  );
}

//appBar
AppBar customAppBar(
    {required String text,
    double size = 20,
    FontWeight weight = FontWeight.normal,
    double elevation = 0,
    bgColor = const Color(0xff92C7CF),
    txtColor = Colors.white}) {
  return AppBar(
    elevation: elevation,
    backgroundColor: bgColor,
    centerTitle: true,
    title: Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: size, fontWeight: weight, color: txtColor),
    ),
  );
}

//TextField for registration page
Widget txtField(
    {TextEditingController? value,
    required context,
    required Color color,
    required String txt}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    elevation: 1,
    child: Container(
      height: height(context: context, value: 0.07),
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
        controller: value,
        obscureText: true,
        cursorColor: color,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.visibility_off,
            color: greenTextColor,
          ),
          hintText: txt,
          hintStyle: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    ),
  );
}

//TextField for user form page
Widget txtFormField(
    {required context, required String text, TextEditingController? textType}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    elevation: 1,
    child: Container(
      height: height(context: context, value: 0.07),
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
        controller: textType,
        cursorColor: greenTextColor,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    ),
  );
}

//dot Text
Widget dotText({required context, required String text, required Color color}) {
  return Padding(
    padding: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.07,
      top: MediaQuery.of(context).size.width * 0.03,
    ),
    child: Row(
      children: [
        Container(
          height: height(context: context, value: 0.02),
          width: height(context: context, value: 0.02),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
          child: styleText(
              text: text,
              txtColor: txtGreyShade,
              size: 15.sp,
              weight: FontWeight.w500),
        ),
      ],
    ),
  );
}
