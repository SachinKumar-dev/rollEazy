import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/vehicle_controller/vehicle_controller.dart';
import '../../utility/widget_helper/widget_helper.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final vehicle = Get.find<VehicleController>().vehicleCache;
  Rx<bool> isTapped = false.obs;
  RxString selectedCategory = ''.obs;

  // Static list to show the category of vehicles
  List<Map<String, dynamic>> category = [
    {
      "path":
          "https://res.cloudinary.com/darxov7ee/image/upload/v1738479889/Adobe_Express_-_file_1_ldpwoq.png",
      "categoryName": "Bike",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path":
          "https://res.cloudinary.com/darxov7ee/image/upload/v1738482592/Adobe_Express_-_file_6_1_edpdx2.png",
      "categoryName": "Hatchback",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path":
          "https://res.cloudinary.com/darxov7ee/image/upload/v1738480687/Adobe_Express_-_file_3_1_imglsx.png",
      "categoryName": "Mini",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path":
          "https://res.cloudinary.com/darxov7ee/image/upload/v1732366360/file_3_ykkrnz.png",
      "categoryName": "Sedan",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
    {
      "path":
          "https://res.cloudinary.com/darxov7ee/image/upload/v1738480863/Adobe_Express_-_file_4_cozqcu.png",
      "categoryName": "Suv",
      "colorOne": const Color(0xff233329),
      "colorTwo": const Color(0xff3B4A42),
      "colorThree": const Color(0xff708871),
      "borderColor": Colors.white
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: SizedBox(
          height: height(context: context, value: 0.25),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (BuildContext context, index) {
              return categoryWidget(
                path: category[index]['path'],
                categoryName: category[index]['categoryName'],
                isSelected:
                    selectedCategory.value == category[index]['categoryName'],
              );
            },
          )),
    );
  }

  Widget categoryWidget(
      {required String path, required categoryName, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        isTapped.value = true;
        selectedCategory.value = categoryName;
        Get.find<VehicleController>().categoryName!.value = categoryName;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isSelected ? 180.h : 150.h,
        width: isSelected ? 180.w : 150.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/categoryOne.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
              imageUrl: path,
              height: 100.h,
              fit: BoxFit.contain,
            ),
            styleText(text: categoryName, size: 15.sp, weight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
