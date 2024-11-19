import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/views/homepage/vehicle_display.dart';
import '../../controllers/vehicle_controller/vehicle_controller.dart';
import '../../utility/color_helper/color_helper.dart';
import '../../utility/widget_helper/widget_helper.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final vehicle = Get.find<VehicleController>().vehicleCache;

  // Static list to show the category of vehicles
  List<Map<String, dynamic>> category = [
    {
      "path": "assets/images/bike.png",
      "categoryName": "Bike",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path": "assets/images/hatchback.png",
      "categoryName": "Hatchback",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path": "assets/images/mini.png",
      "categoryName": "Mini",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path": "assets/images/sedan.png",
      "categoryName": "Sedan",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path": "assets/images/suv.png",
      "categoryName": "Suv",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height(context: context, value: 0.25),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (BuildContext context, index) {
                  return categoryWidget(
                    path: category[index]['path'],
                    categoryName: category[index]['categoryName'],
                    colorOne: category[index]['colorOne'],
                    colorTwo: category[index]['colorTwo'],
                    colorThree: category[index]['colorThree'],
                    borderColor: category[index]['borderColor'],
                  );
                },
              ),
            ),
          ),

          // Title for available vehicles
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: styleText(
              text: "Available vehicles",
              txtColor: greenTextColor,
              weight: FontWeight.w500,
            ),
          ),

          // Dynamically display vehicles or fallback to a "sorry" message
          vehicle.isEmpty
              ? sorryPage()
              : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: VehicleDisplay(),
          ),
        ],
      ),
    );
  }

  Widget categoryWidget({
    required String path,
    required categoryName,
    required Color colorOne,
    required Color colorTwo,
    required Color colorThree,
    required Color borderColor,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        height: height(context: context, value: 0.2),
        width: width(context: context, value: 0.35),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorOne, colorTwo, colorThree],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              path,
              height: 100.h,
            ),
            styleText(text: categoryName, size: 15.sp),
          ],
        ),
      ),
    );
  }

  Widget sorryPage() {
    return Center(
      child: styleText(
        text: "Sorry no vehicles found!",
        txtColor: Colors.black,
      ),
    );
  }
}
