import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/views/homepage/bengaluru_page.dart';
import 'package:roll_eazy/views/homepage/home_screen.dart';
import 'package:roll_eazy/views/homepage/home_tab.dart';
import '../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../controllers/vehicle_controller/vehicle_controller.dart';
import '../../utility/color_helper/color_helper.dart';
import '../../utility/widget_helper/widget_helper.dart';
import '../landing_page/landing_page.dart';
import '../profile_page/profile_page.dart';

class DummyHomepage extends StatefulWidget {
  const DummyHomepage({super.key});

  @override
  State<DummyHomepage> createState() => _DummyHomepageState();
}

class _DummyHomepageState extends State<DummyHomepage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 2) {
      if (Get.find<UserFormController>().isGuest.value == true) {
        Get.offAll(() => const LandingPage());
      } else {
        Get.to((const ProfilePage()), transition: Transition.rightToLeft);
      }
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = Get.find<VehicleController>().vehicleCache;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Header Section
            Container(
              height: height(context: context, value: 0.43),
              width: width(context: context, value: 1),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff233329), Color(0xff3B4A42), Color(0xff708871)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.02,
                    child: styleText(
                      text: "Vehicle Rental",
                      size: 28.sp,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.03,
                    left: 0,
                    child: Image.asset(
                      "assets/logos/homepage_logo.png",
                      scale: 4.5,
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.height * 0.385,
                    child: styleText(text: "@Affordable Prices"),
                  ),
                ],
              ),
            ),

            // HomePage Toggle with Tabs
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tab Bar
                TabBar(
                  padding: EdgeInsets.only(top: 8.h),
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff233329), Color(0xff3B4A42), Color(0xff708871)],
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
                        width: 0.5.sw,
                        alignment: Alignment.center,
                        child: styleText(
                          text: "Ranchi",
                          txtColor: _tabController.index == 0 ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 0.5.sw,
                        alignment: Alignment.center,
                        child: styleText(
                          text: "Bengaluru",
                          txtColor: _tabController.index == 1 ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Tab Views
                SizedBox(
                  height: height(context: context, value: 0.5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // HomeTab
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vehicle.isEmpty
                                ? sorryPage()
                                : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child:  HomeTab(),
                            ),
                          ],
                        ),
                      ),
                      // Bengaluru Tab
                      const Center(
                        child: BengaluruPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
            selectedLabelStyle: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold),
            selectedItemColor: greenTextColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_max_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.transparent),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: 'Profile',
              ),
            ],
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff233329), Color(0xff3B4A42), Color(0xff708871)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sorryPage(){
    return Center(child: styleText(text: "Sorry no vehicle found....",txtColor: Colors.black));
  }

}
