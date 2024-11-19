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
    FontWeight weight = FontWeight.normal, Color color=Colors.white}) {
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

//TextField for user form page
Widget txtFormField(
    {required context,
    required String text,
    TextEditingController? textType,
    TextInputType type = TextInputType.text,
    int length = 50}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: TextField(
      maxLength: length,
      keyboardType: type,
      controller: textType,
      cursorColor: greenTextColor,
      decoration: InputDecoration(
        filled: true,
        hintText: text,
        hintStyle: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.grey),
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}