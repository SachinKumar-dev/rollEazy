import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utility/widget_helper/widget_helper.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 4;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height(context: context, value: 0.4),
        width: width(context: context, value: 0.8),
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
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 16.h), // Spacing
            Text(
              'Rate your driving experience!',
              style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            const SizedBox(height: 16), // Spacing
            RatingBar.builder(
              initialRating: _rating,
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
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (index) {
                      final isHighlighted = _rating > index;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customBars(
                            text: _getLabelForRating(index),
                            hValue: 0.035,
                            wValue: 0.18,
                            isHighlighted: isHighlighted,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(2, (index) {
                      final adjustedIndex = index + 3;
                      final isHighlighted = _rating > adjustedIndex;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customBars(
                            text: _getLabelForRating(adjustedIndex),
                            hValue: 0.035,
                            wValue: 0.18,
                            isHighlighted: isHighlighted,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLabelForRating(int index) {
    switch (index) {
      case 0:
        return "Poor";
      case 1:
        return "Okay";
      case 2:
        return "Average";
      case 3:
        return "Good";
      case 4:
        return "Awesome";
      default:
        return "";
    }
  }

  Widget customBars({
    required String text,
    required double hValue,
    required double wValue,
    required bool isHighlighted,
  }) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      height: height(
          context: context, value: isHighlighted ? hValue + 0.006 : hValue),
      width: width(context: context, value: wValue),
      padding: EdgeInsets.all(isHighlighted ? 3 : 1),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.green[300] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isHighlighted ? Colors.green : Colors.grey,
          width: isHighlighted ? 1.5 : 1,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.4),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Center(
        child: AnimatedOpacity(
          opacity: isHighlighted ? 1.0 : 0.7,
          duration: const Duration(milliseconds: 500),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                decoration: TextDecoration.none,
                color: isHighlighted ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
