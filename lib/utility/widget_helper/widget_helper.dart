 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontSize: size, color: txtColor, fontWeight: weight,textStyle:const TextStyle(overflow: TextOverflow.ellipsis)),
  );
}


