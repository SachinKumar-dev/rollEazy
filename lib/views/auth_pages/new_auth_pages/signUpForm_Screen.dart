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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  style: GoogleFonts.poppins(
                      color: darkBlue, fontWeight: FontWeight.bold),
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
              Image.asset('assets/logos/Ellipse 1.png',
                  scale: MediaQuery.of(context).size.width / 500,fit: BoxFit.cover,),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/logos/Ellipse 2.png',fit: BoxFit.cover,
                  scale: MediaQuery.of(context).size.width / 180,
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/logos/Group 3.png',fit: BoxFit.cover,
                    scale: MediaQuery.of(context).size.width / 350,
                  )),
              Center(
                child: SizedBox(
                  width: width(context: context, value: 0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: ctrl.userName,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.person_2_rounded, color: darkBlue),
                            hintText: "Full name",
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
                          controller: ctrl.mobileNumber,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_rounded,
                                color: darkBlue),
                            hintText: "Mobile number",
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
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          onTap: () async {
                            _focusNodeOne.requestFocus();
                            final DateTime? selected = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900, 1, 1),
                              lastDate: DateTime.now(),
                            );
                            if (selected != null) {
                              String formatedDate =
                                  DateFormat('dd-MM-yyyy').format(selected);
                              ctrl.dob.text = formatedDate.toString();
                            }
                          },
                          focusNode: _focusNodeOne,
                          readOnly: true,
                          controller: ctrl.dob,
                          cursorColor: darkBlue,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            hintText: "DOB as per Aadhar",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 15.sp, color: Colors.black38),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: darkBlue, width: 2),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          onTap: () {
                            _focusNodeTwo.requestFocus();
                            _showDropdownMenu(_genderItems, ctrl.gender);
                          },
                          focusNode: _focusNodeTwo,
                          readOnly: true,
                          controller: ctrl.gender,
                          cursorColor: darkBlue,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            hintText: "Gender",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 15.sp, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: lightBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: darkBlue, width: 2),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          onTap: () {
                            _focusNodeThree.requestFocus();
                            _showDropdownMenu(_licenseItems, ctrl.license);
                          },
                          focusNode: _focusNodeThree,
                          readOnly: true,
                          controller: ctrl.license,
                          cursorColor: darkBlue,
                          decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            hintText: "Driving License",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 15.sp, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: lightBlue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: darkBlue, width: 2),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              styleText(
                                  text: "Profile Picture",
                                  txtColor: darkBlue,
                                  size: 16.sp,
                                  weight: FontWeight.w500),
                              Container(
                                height: height(context: context, value: 0.04),
                                width: width(context: context, value: 0.2),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      lightBlue,
                                      darkBlue,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Obx(
                                    () => IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        controller.imagePicker();
                                      },
                                      icon: Icon(
                                        Icons.image,
                                        color: controller.isImageSelected.value
                                            ? Colors.white
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1.2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.r),
                          splashColor: darkBlue,
                          onTap: () async {
                            HapticFeedback.lightImpact();
                            FocusManager.instance.primaryFocus?.unfocus();
                            ctrl.formValidations();
                          },
                          child: Container(
                            height: height(context: context, value: 0.04),
                            width: width(context: context, value: 0.2),
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
                                    text: "Next",
                                    size: 16.sp,
                                    weight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
