import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import '../../models/vehicle_model/vehicle_model.dart';

class ReviewCard extends StatefulWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

  String formatDate(String mongoDate) {
    DateTime dateTime = DateTime.parse(mongoDate);

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient:  LinearGradient(
            colors: [
              lightBlue,
              darkBlue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.review.starsCount,
                    (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.star_rate_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            const Divider(indent: 20, endIndent: 20),
            Text(widget.review.feedback,style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp)),
            const Divider(indent: 20, endIndent: 20),
            Text(formatDate(widget.review.createdAt.toString()),style: GoogleFonts.poppins(color: Colors.white,fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}