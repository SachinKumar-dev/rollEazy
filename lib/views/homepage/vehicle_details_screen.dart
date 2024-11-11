import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/controllers/vehicle_controller/vehicle_controller.dart';
import 'package:roll_eazy/models/vehicle_model/vehicle_model.dart';
import 'package:roll_eazy/utility/widget_helper/expandable_helper.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {


  final vehicleController = Get.find<VehicleController>();
  @override
  void initState(){
    Get.find<VehicleController>().getDetailedData( id: Get.find<VehicleController>().vehicleId.value);
    super.initState();
  }

  // Page view logic
  int pageLength = 3;
  int currentIndexPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ExpandablePageView(
              onPageChanged: _onPageChanged,
              children: [
                pageView(context, "assets/logos/mainlogo.png"),
                pageView(context, "assets/logos/mainlogo.png"),
                pageView(context, "assets/logos/mainlogo.png"),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  ExpandableHelper(
                      path: "assets/logos/road.png",
                      text: "Current KM",
                      colorText: txtGreyShade,
                      size: 16),
                  const Divider(),
                  ExpandableHelper(
                      path: "assets/logos/deposit.png",
                      text: "Deposit",
                      colorText: txtGreyShade,
                      size: 16),
                  const Divider(),
                  ExpandableHelper(
                      path: "assets/logos/save-money.png",
                      text: "Extra Charges",
                      colorText: txtGreyShade,
                      size: 16),
                  const Divider(),
                  ExpandableHelper(
                      path: "assets/logos/rating.png",
                      text: "Reviews",
                      colorText: txtGreyShade,
                      size: 16),
                  const Divider(),
                  ExpandableHelper(
                      path: "assets/logos/hanging.png",
                      text: "Non-Functional Parts",
                      colorText: txtGreyShade,
                      size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //multiple images showing ui
  Widget pageView(BuildContext context, String path) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
      child: Stack(
        children: [
          Container(
            height: height(context: context, value: 0.3),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff233329),
                  Color(0xff3B4A42),
                  Color(0xff708871),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 7.h,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: pageLength,
              position: currentIndexPage,
              decorator: DotsDecorator(
                color: Colors.grey.shade400,
                activeColor: Colors.white,
                size: Size.square(5.sp),
                activeSize: Size(18.sp, 8.sp),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
