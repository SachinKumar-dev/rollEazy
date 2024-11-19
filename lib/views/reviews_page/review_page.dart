import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.r), // Rounded corners for the card
          ),
          child: Container(
            height: height(context: context, value: 0.12),
            width: width(context: context, value: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff233329),
                  Color(0xff3B4A42),
                  Color(0xff708871)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.star_rate_sharp,
                              color: Colors.white,
                              size: 30, // Adjust size if needed
                            ),
                          ),
                        ))),
                //divider
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                //feedback
                styleText(text: "Awesome", color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
