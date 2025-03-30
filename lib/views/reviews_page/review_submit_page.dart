import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/review_controller/review_controller.dart';
import '../../utility/color_helper/color_helper.dart';
import '../../utility/widget_helper/widget_helper.dart';

class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> reviewData;
  const ReviewPage({super.key, required this.reviewData});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int starsCount = 5;
  String selectedFeedback = 'Outstanding';

  final Map<int, List<String>> feedbackOptions = {
    1: ['Poor', 'Not Satisfactory'],
    2: ['Average', 'Can Improve'],
    3: ['Decent', 'Satisfactory'],
    4: ['Nice', 'Very Good'],
    5: ['Awesome', 'Outstanding'],
  };

  @override
  Widget build(BuildContext context) {
    final review = widget.reviewData;
    final vehicleName = review['VehicelName'];
    final vehicleNumber = review['VehicleNumber'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: height(context: context, value: 0.4),
            width: width(context: context, value: 0.85),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: (){
                      Get.find<ReviewController>().changeStatusOfPopUp(widget.reviewData);
                      Get.back();
                    }
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Rate your driving experience!',
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: Colors.black),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Vehicle: $vehicleName ($vehicleNumber)',
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp, color: Colors.grey[700],fontWeight: FontWeight.w500,textStyle: const TextStyle(overflow: TextOverflow.ellipsis)),
                ),
                SizedBox(height: 16.h),
                RatingBar.builder(
                  initialRating: starsCount.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      starsCount = rating.toInt();
                      selectedFeedback =
                          '';
                    });
                  },
                ),
                SizedBox(height: 16.h),
                starsCount > 0
                    ? Wrap(
                        spacing: 8.w,
                        children: feedbackOptions[starsCount]!
                            .map(
                              (feedback) => ChoiceChip(
                                color: WidgetStatePropertyAll(bgColor),
                                label: Text(feedback),
                                selected: selectedFeedback == feedback,
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedFeedback =
                                        isSelected ? feedback : '';
                                  });
                                },
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(),
                SizedBox(height: 16.h),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(lightBlue),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0.r),
                      ),
                    ),
                  ),
                  onPressed: selectedFeedback.isNotEmpty
                      ? () {
                          Get.find<ReviewController>().submitReview(
                            widget.reviewData,
                            starsCount,
                            selectedFeedback,
                          );
                        }
                      : null,
                  child: styleText(
                    text: "Submit",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
