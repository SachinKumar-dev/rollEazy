import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/views/homepage/vehicle_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/vehicle_controller/vehicle_controller.dart';
import '../../models/vehicle_model/vehicle_model.dart';
import '../../utility/color_helper/color_helper.dart';
import '../../utility/widget_helper/widget_helper.dart';
import 'home_tab.dart';

class ActualHomepage extends StatefulWidget {
  const ActualHomepage({super.key});

  @override
  State<ActualHomepage> createState() => _ActualHomepageState();
}

class _ActualHomepageState extends State<ActualHomepage> {
  final vehicleController = Get.find<VehicleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height(context: context, value: 0.36),
              width: width(context: context, value: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [lightBlue, darkBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: height(context: context, value: 0.05),
                    left: width(context: context, value: 0.02),
                    child: styleText(
                      text: "Vehicle Rental",
                      size: 28.sp,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    top: height(context: context, value: 0.03),
                    left: 0,
                    child: Image.asset(
                      "assets/logos/homepage_logo.png",
                      scale: 5.5,
                    ),
                  ),
                  Positioned(
                    left: width(context: context, value: 0.02),
                    top: height(context: context, value: 0.32),
                    child: styleText(text: "@Affordable Prices"),
                  ),
                ],
              ),
            ),
            const HomeTab(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return SizedBox(
                        height: 250.h,
                        child: FutureBuilder<List<Vehicle>?>(
                          future: Get.find<VehicleController>()
                                  .categoryName!
                                  .value
                                  .isEmpty
                              ? Get.find<VehicleController>().getAllVehicles()
                              : Get.find<VehicleController>().categoryVehicles(
                                  category: Get.find<VehicleController>()
                                      .categoryName!
                                      .value),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HomePageShimmer();
                            } else if (snapshot.hasData) {
                              final data = snapshot.data;
                              if (data == null || data.isEmpty) {
                                final categoryName =
                                    Get.find<VehicleController>()
                                        .categoryName!
                                        .value;
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categoryName.isEmpty
                                            ? "No vehicles yet!"
                                            : "No $categoryName available!",
                                        style: GoogleFonts.poppins(
                                          fontSize: 17.sp,
                                          color: darkBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Lottie.asset(
                                          "assets/logos/blueNotFound.json",
                                          height: 100.h)
                                    ],
                                  ),
                                );
                              }
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final vehicle = data[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.find<VehicleController>()
                                            .vehicleId
                                            .value = vehicle.id;
                                        Get.to(() => const MainScreen(),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Container(
                                        height: 225.h,
                                        width: 180.w,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/available.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 130.h,
                                              width: 160.w,
                                              child: Image.network(
                                                vehicle.coverImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              vehicle.vehicleName,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Divider(
                                              endIndent: 15,
                                              indent: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12.w, top: 6.h),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.location_pin,
                                                      color: darkBlue),
                                                  Text(
                                                    vehicle.state,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.w, top: 6.h),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0),
                                                        child: styleText(
                                                          text: "₹ ",
                                                          txtColor: darkBlue,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${vehicle.pricePerHour}/hr",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 40.w),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .event_seat_rounded,
                                                          color: darkBlue),
                                                      SizedBox(width: 5.w),
                                                      Text(
                                                        "${vehicle.seater}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: styleText(
                                  text: "Unable to fetch vehicles!",
                                  txtColor: darkBlue,
                                  weight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageShimmer extends StatefulWidget {
  const HomePageShimmer({super.key});

  @override
  State<HomePageShimmer> createState() => _HomePageShimmerState();
}

class _HomePageShimmerState extends State<HomePageShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: darkBlue,
        child: SizedBox(
          height: height(context: context, value: 0.17),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: darkBlue,
                    child: Container(
                      height: height(context: context, value: 0.17),
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
