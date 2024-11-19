import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/homepage/tabBarView.dart';
import 'package:roll_eazy/views/landing_page/landing_page.dart';
import 'package:roll_eazy/views/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

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

  final ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      bool isCollapsed = _scrollController.offset > 50.h;
      if (_isAppBarCollapsed != isCollapsed) {
        setState(() {
          _isAppBarCollapsed = isCollapsed;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: height(context: context, value: 0.42),
              pinned: false,
              floating: false,
              flexibleSpace: _isAppBarCollapsed
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12.r),
                      )),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Lottie.asset("assets/images/homepage.json",
                                frameRate: const FrameRate(60),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : FlexibleSpaceBar(
                      background: Container(
                        height: height(context: context, value: 0.42),
                        width: width(context: context, value: 1),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff233329),
                              Color(0xff3B4A42),
                              Color(0xff708871),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
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
                              top: MediaQuery.of(context).size.height * 0.4,
                              child: styleText(text: "@Affordable Prices"),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SliverToBoxAdapter(child: HomePageToggle()),
          ],
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12.sp, fontWeight: FontWeight.w500),
              selectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 14.sp, fontWeight: FontWeight.bold),
              selectedItemColor: greenTextColor,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_max_rounded,
                    weight: 10.0,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.transparent),
                  // Hidden
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
                  label: 'Profile',
                ),
              ],
            ),
            Positioned(
              top: -30, // Move the search icon up
              left: MediaQuery.of(context).size.width / 2 -
                  30, // Center the search icon
              child: GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff233329),
                        Color(0xff3B4A42),
                        Color(0xff708871),
                      ],
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
                  child:
                      const Icon(Icons.search, color: Colors.white, size: 35),
                ),
              ),
            ),
          ],
        ));
  }
}
