import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: styleText(
              text: "Profile", txtColor: txtGreyShade, weight: FontWeight.w500),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(context: context, value: 0.04),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Name *", txtColor: greenTextColor, size: 15.sp),
            ),
            textFormField(context),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Mobile Number *",
                  txtColor: greenTextColor,
                  size: 15.sp),
            ),
            textFormField(context),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Email *", txtColor: greenTextColor, size: 15.sp),
            ),
            textFormField(context),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "DOB *", txtColor: greenTextColor, size: 15.sp),
            ),
            textFormField(context),
            SizedBox(
              height: height(context: context, value: 0.04),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: SizedBox(
                height: height(context: context, value: 0.06),
                width: MediaQuery.of(context).size.width * 0.88,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(greenTextColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                        )),
                    onPressed: () {},
                    child: styleText(
                        text: "Submit",
                        txtColor: Colors.white,
                        size: textSize(value: 13.sp),
                        weight: FontWeight.w500)),
              ),
            ),
            Divider(
              height: 50.h,
              indent: 30.w,
              endIndent: 30.w,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.085),
              child: styleText(
                  text: "Delete Account",
                  size: 15.sp,
                  txtColor: Colors.red,
                  weight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.085),
              child: styleText(
                  text:
                      "Deleting your account will remove all\nof your details",
                  size: 15.sp,
                  txtColor: txtGreyShade),
            )
          ],
        ),
      ),
    );
  }

  Widget textFormField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      height: height(context: context, value: 0.06),
      child: Center(
        child: TextFormField(
          maxLines: 1,
          cursorColor: greenTextColor,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              filled: true,
              fillColor: const Color.fromARGB(255, 207, 223, 207),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.r))),
        ),
      ),
    );
  }
}
