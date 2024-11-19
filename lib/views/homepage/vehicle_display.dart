import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class VehicleDisplay extends StatelessWidget {
  const VehicleDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 1, // Adds shadow to make the card stand out
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12.r), // Rounded corners for the card
        ),
        child: Container(
          padding: EdgeInsets.all(12.w),
          // Adds padding inside the container
          height: height(context: context, value: 0.4),
          // Dynamic height
          width: width(context: context, value: 1),
          // Full screen width
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff233329), Color(0xff3B4A42), Color(0xff708871)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Take only necessary vertical space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite,color: Colors.white,),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: -100.h, // Shift the image upwards
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/sedan.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Add minimal spacing below the image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  styleText(
                      text: "Lambo Urus",
                      txtColor: Colors.white,
                      weight: FontWeight.w600),
                  styleText(
                      text: "300/hr",
                      txtColor: Colors.white,
                      weight: FontWeight.w500,
                      size: 15.sp),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.setting_fill,
                          color: Colors.white54,
                          size: 15,
                        ),
                      ),
                      styleText(
                          text: "Automatic",
                          size: 15.sp,
                          txtColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.car_fill,
                          color: Colors.white54,
                          size: 15,
                        ),
                      ),
                      styleText(
                          text: "4", size: 15.sp, txtColor: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.oil_barrel,
                          color: Colors.white54,
                          size: 15,
                        ),
                      ),
                      styleText(
                          text: "Diesel",
                          size: 15.sp,
                          txtColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
