import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/auth_pages/registration_page/register_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserFormController>(
        autoRemove: false,
        assignId: true,
        builder: (ctrl) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        top: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      children: [
                        styleText(
                            text: "User Form",
                            txtColor: newtestColor,
                            size: 25.sp,
                            weight: FontWeight.w500),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.06),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: height(context: context, value: 0.2),
                                width: width(context: context, value: 0.5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        width: 1.5, color: Colors.grey)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_enhance_rounded,
                                      color: newtestColor,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height(context: context, value: 0.04),
                                  width: width(context: context, value: 0.5),
                                  decoration: BoxDecoration(
                                      color: newtestColor,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Center(
                                      child: styleText(
                                          text: "Profile Image", size: 15.sp)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width(context: context, value: 0.01),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: height(context: context, value: 0.2),
                                width: width(context: context, value: 0.5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.grey,
                                    )),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_enhance_rounded,
                                      color: newtestColor,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height(context: context, value: 0.04),
                                  width: width(context: context, value: 0.5),
                                  decoration: BoxDecoration(
                                      color: newtestColor,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Center(
                                      child: styleText(
                                          text: "Cover Image", size: 15.sp)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  txtFormField(
                      context: context,
                      text: "First Name",
                      textType: ctrl.firstName),
                  SizedBox(
                    height: height(context: context, value: 0.01),
                  ),
                  txtFormField(
                      context: context,
                      text: "Last Name",
                      textType: ctrl.lastName),
                  SizedBox(
                    height: height(context: context, value: 0.01),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            elevation: 1,
                            child: Container(
                              height: height(context: context, value: 0.07),
                              width: width(context: context, value: 0.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: -22,
                                    // How much the shadow spreads
                                    blurRadius: 10,
                                    // Softness of the shadow
                                    offset: const Offset(-5, 28),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: ctrl.dob,
                                cursorColor: newtestColor,
                                decoration: InputDecoration(
                                  hintText: "DOB as per aadhar",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15.sp, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Card(
                            elevation: 1,
                            child: Container(
                              height: height(context: context, value: 0.063),
                              width: width(context: context, value: 0.3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: newtestColor.withOpacity(0.5),
                                    spreadRadius: -25,
                                    // How much the shadow spreads
                                    blurRadius: 10,
                                    // Softness of the shadow
                                    offset: const Offset(-5, 27),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              newtestColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                        ),
                                      )),
                                  onPressed: () async {
                                    final DateTime? selected =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900, 1, 1),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selected != null) {
                                      String formatedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(selected);
                                      ctrl.dob.text = formatedDate.toString();
                                    }
                                  },
                                  child: styleText(
                                      text: "Date",
                                      txtColor: Colors.white,
                                      size: textSize(value: 15.sp))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height(context: context, value: 0.01),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          dotText(context: context, text: "Gender"),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "Male",
                                        //its id
                                        groupValue: ctrl.gender,
                                        //this shows button
                                        onChanged: (String? value) {
                                          setState(() {
                                            ctrl.gender = value!;
                                            ctrl.gender = ctrl.gender;
                                          });
                                        }),
                                    styleText(
                                        text: "Male",
                                        txtColor: txtGreyShade,
                                        size: 15.sp) //for frontend purpose
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "Female",
                                        groupValue: ctrl.gender,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ctrl.gender = value!;
                                            ctrl.gender = ctrl.gender;
                                          });
                                        }),
                                    styleText(
                                        text: "Female",
                                        txtColor: txtGreyShade,
                                        size: 15.sp)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "Others",
                                        groupValue: ctrl.gender,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ctrl.gender = value!;
                                            ctrl.gender = ctrl.gender;
                                          });
                                        }),
                                    styleText(
                                        text: "Others",
                                        txtColor: txtGreyShade,
                                        size: 15.sp)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dotText(context: context, text: "Driving License?"),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "Yes",
                                        //its id
                                        groupValue: ctrl.license,
                                        //this shows button
                                        onChanged: (String? value) {
                                          setState(() {
                                            ctrl.license = value!;
                                            ctrl.license = ctrl.license;
                                          });
                                        }),
                                    styleText(
                                        text: "Yes",
                                        txtColor: txtGreyShade,
                                        size: 15.sp) //for frontend purpose
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "No",
                                        groupValue: ctrl.license,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ctrl.license = value!;
                                            ctrl.license = ctrl.license;
                                          });
                                        }),
                                    styleText(
                                        text: "No",
                                        txtColor: txtGreyShade,
                                        size: 15.sp)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Card(
                    elevation: 1,
                    child: Container(
                      height: height(context: context, value: 0.063),
                      width: width(context: context, value: 0.9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: newtestColor.withOpacity(0.5),
                            spreadRadius: -25, // How much the shadow spreads
                            blurRadius: 10, // Softness of the shadow
                            offset: const Offset(-5, 27),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(headingColorText),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0.r),
                                ),
                              )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: styleText(
                              text: "Next Step",
                              txtColor: Colors.white,
                              size: textSize(value: 15.sp))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.06),
                    child: StepProgressIndicator(
                      roundedEdges: Radius.circular(20.r),
                      totalSteps: 2,
                      currentStep: 1,
                      selectedColor: newtestColor,
                      unselectedColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
