import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/controllers/ride_controller/ride_controller.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import '../../utility/color_helper/color_helper.dart';
import '../../utility/widget_helper/widget_helper.dart';
import '../ride_details/all_rides_page.dart';

class RefundPage extends StatefulWidget {
  const RefundPage({super.key});

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  final ctrl = Get.find<RideController>();
  final RxString expandedRideId = "".obs;
  final RxBool isSearchActive = false.obs;
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
  List refundList = [];
  List filteredRefundList = [];

  @override
  void initState() {
    super.initState();
    fetchRefunds();
  }

  Future<void> fetchRefunds() async {
    isLoading = true;
    try {
      final data = await ctrl.getRefundData(
          userId: Get.find<GlobalUserController>().user.value!.id);
      setState(() {
        refundList = data ?? [];
        filteredRefundList = refundList;
      });
      isLoading = false;
    } catch (e) {
      isLoading = false;
      if (kDebugMode) {
         print("Error fetching refunds: $e");
      }
    }
  }

  void toggleSearch() {
    if (isSearchActive.value) {
      searchController.clear();
      filteredRefundList = refundList;
    }
    isSearchActive.value = !isSearchActive.value;
  }

  void filterRefunds(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRefundList = refundList;
      } else {
        filteredRefundList = refundList
            .where((refund) => refund.rideId?.contains(query) ?? false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBlue,
        onPressed: toggleSearch,
        child: Obx(
          () => Icon(
            isSearchActive.value ? Icons.close : Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: darkBlue,
            )),
        title: Obx(() {
          return isSearchActive.value
              ? TextField(
                  controller: searchController,
                  onChanged: filterRefunds,
                  decoration: InputDecoration(
                    hintText: "Search by Ride ID...",
                    hintStyle: GoogleFonts.poppins(color: Colors.black),
                  ),
                  style: GoogleFonts.poppins(color: Colors.black),
                )
              : styleText(
                  text: "Refund",
                  txtColor: Colors.black,
                  weight: FontWeight.w500);
        }),
        centerTitle: true,
      ),
      body: isLoading
          ? const EndRideShimmer(
              shimmerCount: 5,
            )
          : filteredRefundList.isEmpty
              ? Center(
                  child: Text(
                    "No refunds found!",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredRefundList.length,
                  itemBuilder: (context, index) {
                    final refund = filteredRefundList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        final isExpanded =
                            expandedRideId.value == refund.rideId;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: darkBlue,
                              ),
                              child: ListTile(
                                leading: Text(
                                  "₹",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.sp, color: Colors.white),
                                ),
                                title: Text(
                                  "RideId:",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                subtitle: Text(refund.rideId ?? "",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white)),
                                trailing: IconButton(
                                  onPressed: () {
                                    if (isExpanded) {
                                      // Collapse the expanded container
                                      expandedRideId.value = "";
                                    } else {
                                      // Expand this rideId
                                      expandedRideId.value =
                                          refund.rideId ?? "";
                                    }
                                  },
                                  icon: Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                margin: EdgeInsets.only(top: 8.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow("Refund Amount:",
                                        "₹ ${refund.refundAmount}"),
                                    _buildDetailRow("Refund Reason:",
                                        refund.refundReason ?? ""),
                                    _buildDetailRow("Refunded Date:",
                                        refund.refundedDate ?? ""),
                                    _buildDetailRow("Transaction ID:",
                                        refund.transactionId ?? ""),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }),
                    );
                  },
                ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
