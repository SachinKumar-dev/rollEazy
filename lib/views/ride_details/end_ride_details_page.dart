import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import '../../controllers/ride_controller/ride_controller.dart';
import '../homepage/vehicle_details_screen.dart';

class EndRideDetailedPage extends StatefulWidget {
  final String rideId;

  const EndRideDetailedPage({super.key, required this.rideId});

  @override
  State<EndRideDetailedPage> createState() => _EndRideDetailedPageState();
}

class _EndRideDetailedPageState extends State<EndRideDetailedPage>
    with SingleTickerProviderStateMixin {
  final ctrl = Get.find<RideController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:bgColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_rounded,color: darkBlue,)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Ride Details",
          style: GoogleFonts.poppins(
            color: Colors.black,fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ctrl.getEndedRideUrlAsPerRideId(rideId: widget.rideId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MainScreenShimmer();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong!",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            );
          }
          final data = snapshot.data;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderImage(),
                  SizedBox(height: 20.h),
                  _buildAnimatedSection("General Info.", [
                    _buildInfoRow("From:", data!.from),
                    _buildInfoRow("To:", data.to),
                    _buildInfoRow("Contact No.:", data.mobileNo),
                    _buildInfoRow("Penalty Reason:", data.penaltyReason),
                    _buildInfoRow(
                        "Rider's Rating:", data.customerRating.toString()),
                    _buildInfoRow(
                        "Travellers Count:", data.personCount.toString()),
                    _buildInfoRow("Start Date:", data.startDate),
                    _buildInfoRow("End Date:", data.endDate),
                    _buildInfoRow("Start Time:", data.startTime.toString()),
                    _buildInfoRow("End Time:", data.endTime.toString()),
                    GestureDetector(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: data.id));
                        },
                        child: _buildInfoRow("Ride ID: (Copy)      ", data.id)),

                  ]),
                  _buildAnimatedSection("Vehicle Info.", [
                    _buildInfoRow("Vehicle Name:", data.vehicleName),
                    _buildInfoRow("Vehicle Number:", data.vehicleNumber),
                    _buildInfoRow("Distance Covered:",
                        "${data.distanceCovered.toString()} KM"),
                  ]),
                  _buildAnimatedSection("Payment Info.", [
                    _buildInfoRow(
                        "Amount Paid:", "₹ ${data.amountPaid.toString()}"),
                    _buildInfoRow(
                        "Penalty Paid:", "₹ ${data.penaltyPaid.toString()}"),
                    GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: data.transactionID));
                        },
                        child: _buildInfoRow(
                            "Transaction ID: (Copy)     ", data.transactionID)),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child:
              Lottie.asset("assets/logos/map.json",repeat: false,fit: BoxFit.cover,height: 180.h),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Card(
          color: darkBlue,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: rows,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h,top: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: darkBlue,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.white,
                textStyle: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
