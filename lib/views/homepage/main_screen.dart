import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  // Checkbox state
  bool _isChecked = true;

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildListTile(
                    icon: Icons.car_repair_rounded,
                    title: styleText(
                        text: "Vehicle Condition",
                        txtColor: txtGreyShade,
                        size: 16.sp),
                  ),
                  const Divider(),
                  _buildListTile(
                    icon: Icons.location_on_outlined,
                    title: styleText(
                        text: "Non-Functional Parts",
                        txtColor: txtGreyShade,
                        size: 16.sp),
                  ),
                  const Divider(),
                  _buildListTile(
                    icon: Icons.receipt_outlined,
                    title: styleText(
                        text: "Current KM",
                        txtColor: txtGreyShade,
                        size: 16.sp),
                  ),
                  const Divider(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: headingColorText,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  styleText(
                      text: "I agree to terms and conditions",
                      size: 15.5.sp,
                      txtColor: txtGreyShade)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(headingColorText),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                  ),
                ),
                onPressed: () {},
                child: styleText(
                    text: "Enquiry", size: 15.5.sp, txtColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required Widget title}) {
    return ListTile(
      leading: Icon(
        weight: 20,
        icon,
        color: newtestColor,
        size: 17.sp,
      ),
      title: title,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.red,
        size: 15.sp,
      ),
    );
  }

  Widget pageView(BuildContext context, String path) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
      child: Stack(
        children: [
          Container(
            height: height(context: context, value: 0.3),
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
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Center(
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 7.h,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: pageLength,
              position: currentIndexPage,
              decorator: DotsDecorator(
                color: Colors.grey.shade400,
                activeColor: Colors.white,
                size: Size.square(5.sp),
                activeSize: Size(18.sp, 8.sp),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}