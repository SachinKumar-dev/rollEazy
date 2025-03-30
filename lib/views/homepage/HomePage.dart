import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/profile_page/profile_page.dart';
import '../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../landing_page/landing_page.dart';
import 'ActualHomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ActualHomepage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      if (Get.find<UserFormController>().isGuest.value == true) {
        Get.offAll(() => const LandingPage());
        return;
      }
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (isSuccess, result) {
        if (isSuccess) {
          SystemNavigator.pop();
        } else {
          //print('Pop action failed or canceled.');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle:
              GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
          selectedLabelStyle:
              GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold),
          selectedItemColor: darkBlue,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_max_rounded, weight: 10.0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
