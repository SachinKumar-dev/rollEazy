import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roll_eazy/models/ride_model/ride_model.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/ride_details/end_ride_details_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/ride_controller/ride_controller.dart';
import '../../controllers/user_form_ctrl/global_user.dart';
import '../../utility/widget_helper/widget_helper.dart';

class CompletedRidesPage extends StatefulWidget {
  const CompletedRidesPage({super.key});

  @override
  State<CompletedRidesPage> createState() => _CompletedRidesPageState();
}

class _CompletedRidesPageState extends State<CompletedRidesPage> {
  final ctrl = Get.find<RideController>();
  final loggedInUser = Get.find<GlobalUserController>();

  List<RideModel>? rideList = [];
  bool isLoading = true;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    fetchAndSortRides();
  }

  Future<void> fetchAndSortRides() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await ctrl.getEndedRides(rideId: Get.find<GlobalUserController>().user.value!.id);
      setState(() {
        rideList = data;
        sortRideList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void sortRideList() {
    rideList?.sort((a, b) {
      DateTime? dateA = parseDate(a.startDate);
      DateTime? dateB = parseDate(b.startDate);
      if (dateA == null || dateB == null) return 0;
      return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
  }

  DateTime? parseDate(String dateStr) {
    try {
      return DateFormat("dd/MM/yyyy").parse(dateStr);
    } catch (e) {
     // print("Invalid date format: $dateStr");
      return null;
    }
  }

  // Show sorting dialog
  void showSortingDialog() {
    Get.dialog(
      AlertDialog(
        title: Center(
            child: styleText(
                text: "Sort By",
                txtColor: darkBlue,
                size: 18.sp,
                weight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              children: [
                Expanded(
                    child: styleText(
                        text: "Oldest rides",
                        txtColor: Colors.black,
                        size: 16.sp,
                        weight: FontWeight.w500)),
                Radio<bool>(
                  value: true,
                  groupValue: isAscending,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isAscending = value;
                        sortRideList();
                      });
                      Get.back();
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: styleText(
                        text: "Latest rides",
                        txtColor: Colors.black,
                        size: 16.sp,
                        weight: FontWeight.w500)),
                Radio<bool>(
                  value: false,
                  groupValue: isAscending,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isAscending = value;
                        sortRideList();
                      });
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:  Icon(Icons.arrow_back_ios_rounded,color: darkBlue,)),
        actions: [
          IconButton(
            onPressed: showSortingDialog,
            icon: Icon(Icons.sort, color: darkBlue),
          ),
        ],
        centerTitle: true,
        title:  styleText(
            text: "Rides", txtColor: Colors.black, weight: FontWeight.w500),
      ),
      body: isLoading
          ? const EndRideShimmer(shimmerCount: 5)
          : (rideList == null || rideList!.isEmpty)
              ? Center(
                  child: Text(
                  "No rides found!",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                ))
              : ListView.builder(
                  itemCount: rideList!.length,
                  itemBuilder: (context, index) {
                    final ride = rideList![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(EndRideDetailedPage(rideId: ride.id),transition:Transition.rightToLeft);
                        },
                        child: Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: darkBlue,
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                            ),
                            title: Text(
                              "From: ${ride.from}",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            subtitle: Text(
                              "To: ${ride.to}",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            trailing: Text(
                              ride.startDate,
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class EndRideShimmer extends StatefulWidget {
  final int shimmerCount;

  const EndRideShimmer({super.key, required this.shimmerCount});

  @override
  State<EndRideShimmer> createState() => _EndRideShimmerState();
}

class _EndRideShimmerState extends State<EndRideShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: darkBlue,
        child: SizedBox(
          height: height(context: context, value: 0.7),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.shimmerCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: darkBlue,
                  child: Container(
                    height: 50.h,
                    width: 500.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
