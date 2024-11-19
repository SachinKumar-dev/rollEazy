import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/controllers/vehicle_controller/vehicle_controller.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/expandable_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final vehicleController = Get.put(VehicleController());

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
      body: FutureBuilder(
        future: vehicleController.getDetailedData(
            id: vehicleController.vehicleId.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show shimmer or loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error case
            return Center(
              child: styleText(
                text: "Oops, something went wrong!",
                txtColor: Colors.black,
              ),
            );
          } else if (snapshot.hasData) {
            // Use snapshot.data to fetch and display the data
            final data = snapshot.data;
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  // PageView for images
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        ExpandableHelper(
                          expandText: data!.currentKm,
                          path: "assets/logos/road.png",
                          text: "Current KM",
                          colorText: txtGreyShade,
                          size: 16,
                        ),
                        const Divider(),
                        ExpandableHelper(
                          expandText: "₹ ${data.deposit}",
                          path: "assets/logos/deposit.png",
                          text: "Deposit",
                          colorText: txtGreyShade,
                          size: 16,
                        ),
                        const Divider(),
                        ExpandableHelper(
                          expandText: "₹ ${data.extraPerHour }",
                          path: "assets/logos/save-money.png",
                          text: "Extra Charges",
                          colorText: txtGreyShade,
                          size: 16,
                        ),
                        const Divider(),
                        ExpandableHelper(
                          expandText: data.reviews.toString(),
                          path: "assets/logos/rating.png",
                          text: "Reviews",
                          colorText: txtGreyShade,
                          size: 16,
                        ),
                        const Divider(),
                        ExpandableHelper(
                          expandText: data.nonFunctionalParts.toString(),
                          path: "assets/logos/hanging.png",
                          text: "Non-Functional Parts",
                          colorText: txtGreyShade,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Fallback case when snapshot.hasData is false
            return Center(
              child: styleText(
                text: "Oops, no data available!",
                txtColor: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }

  Widget pageView(BuildContext context, String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
              borderRadius: BorderRadius.circular(12),
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
            bottom: 7,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: pageLength,
              position: currentIndexPage,
              decorator: DotsDecorator(
                color: Colors.grey.shade400,
                activeColor: Colors.white,
                size: const Size.square(5),
                activeSize: const Size(18, 8),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
