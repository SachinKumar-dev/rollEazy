import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/homepage/detailed_screen.dart';
import 'package:roll_eazy/views/profile_page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 2) {
      Get.to((const ProfilePage()),transition: Transition.rightToLeft);

      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context: context, value: 0.45),
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
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20)),
                    color: Color(0xff708871)),
                child: Stack(
                  children: [
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.02,
                        child: styleText(
                            text: "Vehicle Rental",
                            size: 28,
                            weight: FontWeight.bold)),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: 0,
                        child: Image.asset(
                          "assets/logos/homepage_logo.png",
                          scale: 4.5,
                        )),
                    Positioned(
                        left: MediaQuery.of(context).size.width * 0.02,
                        top: MediaQuery.of(context).size.height * 0.4,
                        child: styleText(text: "@Affordable Prices")),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height(context: context, value: 0.055),
                        width: width(context: context, value: 0.8),
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
                            color: const Color(0xff708871),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                                topLeft: Radius.circular(10.r))),
                        child: Center(
                            child: styleText(text: "Ranchi", size: 17.sp)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: height(context: context, value: 0.055),
                        width: width(context: context, value: 0.8),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r))),
                        child: Center(
                            child: styleText(text: "Bengaluru", size: 17.sp)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          height: height(context: context, value: 0.2),
                          width: width(context: context, value: 0.3),
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
                              borderRadius: BorderRadius.circular(20.r),
                              //if selected blue bg, white text, else white bg and black text
                              color: const Color(0xff708871)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logos/porsche.png"),
                              styleText(text: "Standard", size: 15.sp),
                              styleText(text: "3000", size: 14.sp),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          height: height(context: context, value: 0.2),
                          width: width(context: context, value: 0.3),
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
                              borderRadius: BorderRadius.circular(20.r),
                              //if selected blue bg, white text, else white bg and black text
                              color: const Color(0xff708871)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logos/porsche.png"),
                              styleText(text: "SUV", size: 15.sp),
                              styleText(text: "3000", size: 14.sp),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          height: height(context: context, value: 0.2),
                          width: width(context: context, value: 0.3),
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
                              borderRadius: BorderRadius.circular(20.r),
                              //if selected blue bg, white text, else white bg and black text
                              color: const Color(0xff708871)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logos/porsche.png"),
                              styleText(text: "Hatchback", size: 15.sp),
                              styleText(text: "3000", size: 14.sp),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          height: height(context: context, value: 0.2),
                          width: width(context: context, value: 0.3),
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
                              borderRadius: BorderRadius.circular(20.r),
                              //if selected blue bg, white text, else white bg and black text
                              color: greenTextColor),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/logos/porsche.png"),
                              styleText(text: "Sedan", size: 15.sp),
                              styleText(text: "3000", size: 14.sp),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: styleText(
                    text: "Available vehicles",
                    txtColor: greenTextColor,
                    weight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  Get.to((const MainScreen()),transition: Transition.rightToLeft);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Stack(children: [
                    Container(
                      height: height(context: context, value: 0.4),
                      width: width(context: context, value: 1),
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
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    styleText(
                                        text: "Toyota Supra",
                                        txtColor: Colors.white,
                                        size: 14.sp),
                                    Container(
                                      height: height(
                                          context: context, value: 0.03),
                                      width:
                                          width(context: context, value: 0.2),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff233329),
                                              Color(0xff3B4A42),
                                              Color(0xff708871),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Center(
                                        child: styleText(
                                            text: "₹ 300/hr",
                                            weight: FontWeight.w500,
                                            size: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: height(
                                                context: context,
                                                value: 0.03),
                                            width: width(
                                                context: context, value: 0.2),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1),
                                                gradient:
                                                    const LinearGradient(
                                                  colors: [
                                                    Color(0xff233329),
                                                    Color(0xff3B4A42),
                                                    Color(0xff708871),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Center(
                                              child: styleText(
                                                  text: "5 Trips",
                                                  weight: FontWeight.w500,
                                                  size: 12.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0.h, left: 10.w),
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: EdgeInsets.only(bottom: 25.h, left: 5.w),
                            height: height(context: context, value: 0.044),
                            width: width(context: context, value: 0.8),
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      AntDesign.setting_fill,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    styleText(text: "Manual", size: 15.sp),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      AntDesign.car_fill,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    styleText(text: "2 Seater", size: 15.sp),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.oil_barrel,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    styleText(text: "Petrol", size: 15.sp),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/logos/mainlogo.png",
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w500),
              selectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.bold),
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
