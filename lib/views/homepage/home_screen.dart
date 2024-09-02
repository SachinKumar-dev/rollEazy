import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
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
      Get.to(const ProfilePage());
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context: context, value: 0.45),
                width: width(context: context, value: 1),
                decoration: const BoxDecoration(
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
                              borderRadius: BorderRadius.circular(20.r),
                              //if selected blue bg, white text, else white bg and black text
                              color: newtestColor),
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
                    txtColor: newtestColor,
                    weight: FontWeight.w500),
              ),
              Stack(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  //here put tap logic
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.3),
                      width: width(context: context, value: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xff708871)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    styleText(
                                        text: "Toyota",
                                        size: 18.sp,
                                        weight: FontWeight.bold),
                                    styleText(text: "Yaris iA", size: 16.sp),
                                    styleText(text: "Petrol", size: 16.sp),
                                  ],
                                ),
                                Column(
                                  children: [
                                    styleText(
                                        text: "3000",
                                        weight: FontWeight.bold,
                                        size: 18.sp),
                                    styleText(text: "/day", size: 16.sp),
                                    styleText(
                                        text: "4-Cyl 1.5ltr", size: 16.sp),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 0,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Image.asset(
                    "assets/logos/mainlogo.png",
                  ),
                )
              ]),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.3),
                      width: width(context: context, value: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff606676)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    styleText(
                                        text: "Toyota",
                                        size: 20,
                                        weight: FontWeight.bold),
                                    styleText(text: "Yaris iA", size: 18),
                                    styleText(text: "Petrol", size: 18),
                                  ],
                                ),
                                Column(
                                  children: [
                                    styleText(
                                        text: "3000", weight: FontWeight.bold),
                                    styleText(text: "/day", size: 18),
                                    styleText(text: "4-Cyl 1.5ltr", size: 18),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 50),
                  child: Image.asset(
                    "assets/logos/mainlogo.png",
                  ),
                )
              ]),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.3),
                      width: width(context: context, value: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff134B70)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    styleText(
                                        text: "Toyota",
                                        size: 20,
                                        weight: FontWeight.bold),
                                    styleText(text: "Yaris iA", size: 18),
                                    styleText(text: "Petrol", size: 18),
                                  ],
                                ),
                                Column(
                                  children: [
                                    styleText(
                                        text: "3000", weight: FontWeight.bold),
                                    styleText(text: "/day", size: 18),
                                    styleText(text: "4-Cyl 1.5ltr", size: 18),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 50),
                  child: Image.asset(
                    "assets/logos/mainlogo.png",
                  ),
                )
              ]),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.3),
                      width: width(context: context, value: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff7AB2B2)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    styleText(
                                        text: "Toyota",
                                        size: 20,
                                        weight: FontWeight.bold),
                                    styleText(text: "Yaris iA", size: 18),
                                    styleText(text: "Petrol", size: 18),
                                  ],
                                ),
                                Column(
                                  children: [
                                    styleText(
                                        text: "3000", weight: FontWeight.bold),
                                    styleText(text: "/day", size: 18),
                                    styleText(text: "4-Cyl 1.5ltr", size: 18),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 50),
                  child: Image.asset(
                    "assets/logos/mainlogo.png",
                    fit: BoxFit.contain,
                  ),
                )
              ]),
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
              selectedItemColor: const Color(0xff708871),
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
                    shape: BoxShape.circle,
                    color: Color(0xff708871),
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
