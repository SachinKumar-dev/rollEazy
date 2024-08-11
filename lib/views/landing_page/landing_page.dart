import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/login_page/login_page.dart';
import 'package:roll_eazy/views/auth_pages/registration_page/register_page.dart';
import 'package:roll_eazy/views/landing_page/Home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  //avoid multiple navigation in animation
  bool _isNavigating = false;

  late AnimationController _controller;
  late AnimationController _tapController;
  late Animation<Offset> _animation;
  late Animation<Offset> _tapAnimation;

  @override
  void initState() {
    super.initState();

    // Initial Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: const Offset(0, 0.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Tap Animation
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _tapAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, -1),
    ).animate(CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _tapController.dispose();
    super.dispose();
  }

  //on tap animation
  void _handleTap() {
    // Start the forward animation
    _tapController.forward();
    // Add a listener to control the navigation and reset
    _tapController.addListener(() {
      // Check if the animation has reached the desired point (e.g., 10% or 0.10)
      if (_tapController.value >= 0.450 && !_isNavigating) {
        _isNavigating = true;
        // Navigate to the new page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        ).then((value) {
          // Reset the animation and flag when coming back
          _tapController.reset();
          _isNavigating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  child: Image.asset("assets/logos/new_bg_logo.png"),
                ),
                Center(
                  child: SlideTransition(
                    position: _animation,
                    child: AnimatedBuilder(
                      animation: _tapAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: _tapAnimation.value *
                              MediaQuery.of(context).size.width,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        "assets/logos/land_logo.png",
                        scale: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height(context: context, value: 0.01),
            ),
            styleText(
              text: "Discover Affordable",
              txtColor: Colors.grey.shade700,
              weight: FontWeight.w500,
              size: 20.sp,
            ),
            styleText(
              text: "Rental Rides",
              txtColor: Colors.grey.shade700,
              weight: FontWeight.w500,
              size: 20.sp,
            ),
            SizedBox(
              height: height(context: context, value: 0.03),
            ),
            styleText(
              text: "Get, Set , Go!",
              txtColor: Colors.grey.shade700,
              weight: FontWeight.w500,
              size: 16.5.sp,
            ),
            SizedBox(
              height: height(context: context, value: 0.08),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SizedBox(
                height: height(context: context, value: 0.08),
                width: width(context: context, value: 0.7),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff800020),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r),
                            ),
                          ),
                          child: Center(
                            child: styleText(
                              size: textSize(value: 16.sp),
                              text: "Sign in",
                              weight: FontWeight.w600,
                              txtColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: btnColorTwo,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Center(
                            child: styleText(
                              size: textSize(value: 16.sp),
                              text: "Register",
                              weight: FontWeight.w600,
                              txtColor: txtGreyShade,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            GestureDetector(
              onTap: () {
                _handleTap();
              },
              child: RichText(
                text: TextSpan(
                  text: 'Guest ',
                  style: GoogleFonts.poppins(
                      fontSize: textSize(value: 16.sp),
                      color: Colors.grey.shade700),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff800020))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
