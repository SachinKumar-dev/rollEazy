import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/homepage/bengaluru_page.dart';
import 'package:roll_eazy/views/homepage/home_tab.dart';

class HomePageToggle extends StatefulWidget {
  const HomePageToggle({super.key});

  @override
  State<HomePageToggle> createState() => _HomePageToggleState();
}

class _HomePageToggleState extends State<HomePageToggle>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab Bar
        TabBar(
          padding: EdgeInsets.only(top: 8.h),
          dividerColor: Colors.transparent,
          controller: _tabController,
          indicator: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff233329),
                Color(0xff3B4A42),
                Color(0xff708871),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            letterSpacing: 1.2,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            letterSpacing: 0.8,
          ),
          tabs: [
            Tab(
              child: Container(
                width: 0.5.sw, // 50% of the screen width
                alignment: Alignment.center,
                child: styleText(
                  text: "Ranchi",
                  txtColor: _tabController.index == 0
                      ? Colors.white
                      : Colors.grey.shade700,
                ),
              ),
            ),
            Tab(
              child: Container(
                width: 0.5.sw, // 50% of the screen width
                alignment: Alignment.center,
                child: styleText(
                  text: "Bengaluru",
                  txtColor: _tabController.index == 1
                      ? Colors.white
                      : Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),

        // Tab View
        SizedBox(
          height: height(context: context, value: 0.5),
          child: TabBarView(
            controller: _tabController,
            children: const [
              HomeTab(),
              BengaluruPage(),
            ],
          ),
        ),
      ],
    );
  }
}
