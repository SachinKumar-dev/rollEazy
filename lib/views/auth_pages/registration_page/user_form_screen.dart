import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../controllers/user_form_ctrl/image_ctrl.dart';
import '../../../controllers/user_form_ctrl/user_form_ctrl.dart';
import '../../../utility/color_helper/color_helper.dart';
import '../../../utility/widget_helper/widget_helper.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final FocusNode _focusNodeOne = FocusNode();
  final FocusNode _focusNodeTwo = FocusNode();
  final FocusNode _focusNodeThree = FocusNode();

  final ImageController controller = Get.find();
  final UserFormController userForm = Get.find();

  // List of items in the dropdown
  final List<String> _genderItems = ['Male', 'Female', 'Others'];
  final List<String> _licenseItems = ['Yes', 'No'];

  void _showDropdownMenu(List<String> items, TextEditingController ctrl) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((String value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  value,
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  setState(() {
                    ctrl.text = value;
                  });
                  Navigator.pop(context); // Close the dropdown
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNodeOne.dispose();
    _focusNodeTwo.dispose();
    _focusNodeThree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetBuilder(
          builder: (UserFormController ctrl) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade200, Colors.teal.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width * 0.3,
                    top: height(context: context, value: 0.1),
                    child: styleText(
                        text: "User details!",
                        size: 25.sp,
                        txtColor: Colors.black,
                        weight: FontWeight.w500)),
                Positioned(
                  left: width(context: context, value: 0.1),
                  top: height(context: context, value: 0.02),
                  child: Container(
                    width: width(context: context, value: 0.5),
                    height: height(context: context, value: 0.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
                // Smaller background elements
                Positioned(
                  left: width(context: context, value: 0.53),
                  bottom: height(context: context, value: 0.14),
                  child: Container(
                    width: width(context: context, value: 0.25),
                    height: height(context: context, value: 0.25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: height(context: context, value: 0.05),
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                txtFormField(
                                    type: TextInputType.name,
                                    context: context,
                                    text: "Full Name",
                                    textType: ctrl.userName),
                                txtFormField(
                                    length: 10,
                                    type: TextInputType.number,
                                    context: context,
                                    text: "Mobile Number",
                                    textType: ctrl.mobileNumber),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: TextField(
                                    onTap: () async {
                                      _focusNodeOne.requestFocus();
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
                                    focusNode: _focusNodeOne,
                                    readOnly: true,
                                    controller: ctrl.dob,
                                    cursorColor: greenTextColor,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      hintText: "DOB as per Aadhar",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      height(context: context, value: 0.028),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: TextField(
                                    onTap: () {
                                      _focusNodeTwo.requestFocus();
                                      _showDropdownMenu(
                                          _genderItems, ctrl.gender);
                                    },
                                    focusNode: _focusNodeTwo,
                                    readOnly: true,
                                    controller: ctrl.gender,
                                    cursorColor: greenTextColor,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      hintText: "Gender",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      height(context: context, value: 0.022),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: TextField(
                                    onTap: () {
                                      _focusNodeThree.requestFocus();
                                      _showDropdownMenu(
                                          _licenseItems, ctrl.license);
                                    },
                                    focusNode: _focusNodeThree,
                                    readOnly: true,
                                    controller: ctrl.license,
                                    cursorColor: greenTextColor,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.3),
                                      filled: true,
                                      hintText: "Driving License",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 30.h),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 20.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        styleText(
                                            text: "Pick Image",
                                            txtColor: Colors.black,
                                            size: 18.sp,
                                            weight: FontWeight.w500),
                                        Container(
                                          height: height(
                                              context: context, value: 0.045),
                                          width: width(
                                              context: context, value: 0.2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 1),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Center(
                                            child: Obx(
                                              () => IconButton(
                                                  onPressed: () {
                                                    controller.imagePicker();
                                                  },
                                                  icon: Icon(
                                                    Icons.image,
                                                    color: controller
                                                            .isImageSelected
                                                            .value
                                                        ? greenTextColor
                                                        : Colors.red,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        FocusManager.instance.primaryFocus?.unfocus();
                        ctrl.formValidations();
                      },
                      child: Card(
                        elevation: 1.2,
                        child: Container(
                          height: height(context: context, value: 0.065),
                          width: width(context: context, value: 0.92),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff2C8E58),
                                    Color(0xff75B6BC)
                                  ])),
                          child: Center(child: styleText(text: "Next Step")),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
