import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../../utility/color_helper/color_helper.dart';
import '../../../utility/widget_helper/widget_helper.dart';
import 'logIn_Screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = true;
  bool isVisibleCPass = true;

  bool isChecked = false;

  //visibility
  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  //visibility
  void toggleVisibilityTwo() {
    setState(() {
      isVisibleCPass = !isVisibleCPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: GetBuilder(builder: (UserFormController ctrl) {
          return Stack(
            children: [
              Image.asset('assets/logos/Ellipse 1.png'),
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/logos/Ellipse 2.png',
                    scale: 1.25,
                  )),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: height(context: context, value: 0.08),
                      left: width(context: context, value: 0.02)),
                  height: height(context: context, value: 0.45),
                  width: width(context: context, value: 0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: styleText(
                            text: "Create User!",
                            txtColor: darkBlue,
                            weight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: ctrl.password,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  toggleVisibility();
                                },
                                icon: isVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: darkBlue,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: darkBlue,
                                      )),
                            prefixIcon:
                                Icon(Icons.lock_rounded, color: darkBlue),
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue, width: 2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintStyle: const TextStyle(color: Colors.black38),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: ctrl.confirmPassword,
                          obscureText: isVisibleCPass,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  toggleVisibilityTwo();
                                },
                                icon: isVisibleCPass
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: darkBlue,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: darkBlue,
                                      )),
                            prefixIcon:
                                Icon(Icons.lock_rounded, color: darkBlue),
                            hintText: "Confirm password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkBlue, width: 2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintStyle: const TextStyle(color: Colors.black38),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.r),
                              splashColor: darkBlue,
                              onTap: () async {
                               if(isChecked){
                                 FocusManager.instance.primaryFocus?.unfocus();
                                 await ctrl.registrationValidations();
                               }else{
                                 Get.snackbar("Oops!", "Please accept terms and conditions",backgroundColor: darkBlue,colorText: Colors.red);
                               }
                              },
                              child: Container(
                                height: height(context: context, value: 0.04),
                                width: width(context: context, value: 0.23),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          lightBlue,
                                          darkBlue,
                                        ])),
                                child: Center(
                                    child: styleText(
                                        text: "Sign Up",
                                        size: 16.sp,
                                        weight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: darkBlue,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          styleText(text: "I accept",size: 14.sp,txtColor: Colors.black),
                          TextButton(
                            onPressed: () {
                              showTermsDialog(context);
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "terms",
                                    style:GoogleFonts.poppins(decoration: TextDecoration.underline,color: darkBlue,fontSize: 14.sp,fontWeight: FontWeight.w500),
                                    ),
                                  TextSpan(
                                    text: " and ",
                                    style:GoogleFonts.poppins(color: Colors.black,fontSize: 14.sp),
                                  ),
                                  TextSpan(
                                    text: "conditions",
                                    style:GoogleFonts.poppins(decoration: TextDecoration.underline,color: darkBlue,fontSize: 14.sp,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: styleText(
                                text: "Have an account ?",
                                size: 16,
                                txtColor: darkBlue,
                                weight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.off(() => const LoginScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: darkBlue, width: 2),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: styleText(
                                      size: 16.sp,
                                      text: "LogIn",
                                      txtColor: darkBlue,
                                      weight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/logos/Group 3.png',
                    scale: 1,
                  )),
            ],
          );
        }),
      ),
    );
  }

  void showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: Text(
            "Roll Eazy",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rental Period",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- The rental starts at pickup and ends at the agreed return time.\n"
                    "- Late returns incur additional charges.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Document Submission",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- The rider must submit their original driving license at the time of vehicle pickup.\n"
                    "- The license will be returned only after the ride is completed",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Payment and Deposit",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- Full payment and a refundable security deposit are required before rental.\n"
                    "- Deductions may apply for damages, fines, or fuel discrepancies.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Vehicle Use",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- The vehicle must be used legally and only by authorized drivers.\n"
                    "- Prohibited uses include racing, towing, and driving under the influence.\n"
                    "- Smoking and illegal activities are not allowed.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Responsibilities",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- The vehicle must be returned in the same condition without exception..\n"
                    "- Report any accidents or damages immediately.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Insurance and Repairs",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- Basic insurance is included; excess fees may apply for damages.\n"
                    "- Unauthorized repairs are not reimbursed.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Breakdowns",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- Notify the Owner of any breakdowns; unauthorized repairs are prohibited.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Liability",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- The Renter is liable for fines, penalties, and personal property loss.\n"
                    "- The Owner is not responsible for such incidents.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Termination",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "- Breach of terms may result in agreement termination without refund.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
