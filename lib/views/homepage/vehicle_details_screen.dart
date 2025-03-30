import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/controllers/ride_controller/ride_controller.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/controllers/vehicle_controller/vehicle_controller.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/expandable_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/reviews_page/review_page.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final vehicleController = Get.put(VehicleController());

  @override
  void initState() {
    setState(() {
      vehicleController.getDetailedData(
          vehicleId: vehicleController.vehicleId.value);
    });
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        //still need to fix this
        populateParts();
      });
    });
  }

  String parts = "";

  void populateParts() {
    for (int i = 0;
        i < vehicleController.data[0].nonFunctionalParts.length;
        i++) {
      if (i == vehicleController.data[0].nonFunctionalParts.length - 1) {
        parts += vehicleController.data[0].nonFunctionalParts[i];
      } else {
        parts += vehicleController.data[0].nonFunctionalParts[i];
      }
    }
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
    return Obx(
      () => Scaffold(
          body: vehicleController.isLoading.value
              ? const MainScreenShimmer()
              : vehicleController.data.isEmpty
                  ? Center(
                      child: Text(
                        "No data available!",
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 250.h,
                            child: PageView.builder(
                              itemCount:
                                  vehicleController.data[0].demoImages.length,
                              onPageChanged: _onPageChanged,
                              itemBuilder: (context, index) {
                                String url =
                                    vehicleController.data[0].demoImages[index];
                                return pageView(context, url);
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Expanded(
                            child: ListView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ExpandableHelper(
                                  expandText:
                                      "${vehicleController.data[0].currentKm} KM",
                                  path: "assets/logos/speedometer.png",
                                  text: "Current KM",
                                  colorText: txtGreyShade,
                                  size: 16,
                                ),
                                const Divider(),
                                ExpandableHelper(
                                  expandText:
                                      "₹ ${vehicleController.data[0].deposit}",
                                  path: "assets/logos/deposit.png",
                                  text: "Deposit",
                                  colorText: txtGreyShade,
                                  size: 16,
                                ),
                                const Divider(),
                                ExpandableHelper(
                                  expandText:
                                      "₹ ${vehicleController.data[0].extraPerHour}",
                                  path: "assets/logos/finance.png",
                                  text: "Extra Charges",
                                  colorText: txtGreyShade,
                                  size: 16,
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => (const ReviewsPage()),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/logos/rating.png",
                                      scale: 18.sp,
                                    ),
                                    title: styleText(
                                        text: "Reviews",
                                        size: 16.sp,
                                        txtColor: txtGreyShade),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                ExpandableHelper(
                                  expandText: parts,
                                  path: "assets/logos/settings.png",
                                  text: "Non-Functional Parts",
                                  colorText: txtGreyShade,
                                  size: 16,
                                ),
                                const Divider(),
                                ExpandableHelper(
                                  expandText:
                                      '• ${vehicleController.data[0].pinCode}, ${vehicleController.data[0].city}\n'
                                      '• ${vehicleController.data[0].gear} '
                                      '• ${vehicleController.data[0].fuel}',
                                  path: "assets/logos/location.png",
                                  text: "Location,Gear,Fuel",
                                  colorText: txtGreyShade,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          //get the card for enquiry
                          Visibility(
                            visible:
                                !Get.find<GlobalUserController>().getGuest(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: darkBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r))),
                                  onPressed: () {
                                    _showCallOptions(context);
                                  },
                                  child: styleText(
                                      text: "Enquire",
                                      size: 16.sp,
                                      weight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                    )),
    );
  }

  //show multiple number selections
  void _showCallOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: height(context: context, value: 0.2),
          decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r))),
              child:Column(
                children: [
                  ListTile(
                    title: Text(
                      vehicleController.data[0].primaryNum,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.find<RideController>()
                          .launchCallerApp(vehicleController.data[0].primaryNum);
                    },
                            ),
                  vehicleController.data[0].secondaryNum.isEmpty?const SizedBox():ListTile(
                    title: Text(
                  vehicleController.data[0].secondaryNum,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.find<RideController>()
                          .launchCallerApp(vehicleController.data[0].secondaryNum);
                    },
                  ),
                ],
              ),
        );
      },
    );
  }

  Widget pageView(BuildContext context, String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: path,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
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
          ],
        ),
      ),
    );
  }
}

class MainScreenShimmer extends StatelessWidget {
  const MainScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 7.w),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: darkBlue,
            child: Container(
              height: 200.h,
              width: 500.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: darkBlue,
                    child: Container(
                      height: 60.h,
                      width: 500.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
