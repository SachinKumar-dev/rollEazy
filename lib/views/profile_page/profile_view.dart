import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import '../../controllers/user_form_ctrl/global_user.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserFormController ctrl = Get.find<UserFormController>();
  final GlobalUserController loggedInUser = Get.find<GlobalUserController>();

  String? get number => loggedInUser.user.value?.mobileNumber;
  final FocusNode _focusNodeOne = FocusNode();

  @override
  void initState() {
    ctrl.pNumber.text = number!;
    super.initState();
    ctrl.textFieldCheck();
  }

  @override
  void dispose() {
    _focusNodeOne.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: styleText(
              text: "Profile", txtColor: Colors.black, weight: FontWeight.w500),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:  Icon(Icons.arrow_back_ios_new_rounded,color: darkBlue,))),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(context: context, value: 0.04),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Name *", txtColor: darkBlue, size: 15.sp),
            ),
            textFormField(context, ctrl.pName),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Mobile Number",
                  txtColor: darkBlue,
                  size: 15.sp),
            ),
            textFormField(context, ctrl.pNumber,
                value: true, textColor: Colors.grey.shade600),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "Email *", txtColor: darkBlue, size: 15.sp),
            ),
            textFormField(context, ctrl.pEmail),
            SizedBox(
              height: height(context: context, value: 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, bottom: 3.h),
              child: styleText(
                  text: "DOB *", txtColor: darkBlue, size: 15.sp,),
            ),
            textFormField(context, ctrl.pDOB,value: true,datePicker: ()async{
                // Show date picker on tap
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900, 1, 1),
                  lastDate: DateTime.now(),
                );
                if (selected != null) {
                  // Format and set selected date in the text field
                  String formattedDate = DateFormat('dd-MM-yyyy').format(
                      selected);
                  ctrl.pDOB.text = formattedDate;
                }
            }),
            SizedBox(
              height: height(context: context, value: 0.04),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
              ),
              child: SizedBox(
                height: height(context: context, value: 0.06),
                width: MediaQuery.of(context).size.width * 0.88,
                child: Obx(
                  () => ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        ctrl.isFiled.value ? darkBlue : Colors.grey,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                      ),
                    ),
                    onPressed: ctrl.isFiled.value
                        ? () async {
                            await ctrl.updateDetails();
                          }
                        : null,
                    child: styleText(
                      text: "Submit",
                      txtColor: Colors.white,
                      size: textSize(value: 13.sp),
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 50.h,
              indent: 30.w,
              endIndent: 30.w,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.085),
              child: GestureDetector(
                onTap: () {
                  Get.find<UserFormController>().showDeleteConfirmationDialog(context);
                },
                child: styleText(
                    text: "Delete Account",
                    size: 15.sp,
                    txtColor: Colors.red,
                    weight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.085),
              child: styleText(
                  text:
                      "Deleting your account will remove all\nof your details",
                  size: 15.sp,
                  txtColor: txtGreyShade),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFormField(BuildContext context, TextEditingController controller,
      {bool? value, Color? textColor, Function? datePicker}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      height: height(context: context, value: 0.06),
      child: Center(
        child: TextFormField(
          onTap: (){
            if(datePicker!=null){
              datePicker();
            }
          },
          style: GoogleFonts.poppins(color: textColor ?? Colors.black),
          readOnly: value ?? false,
          controller: controller,
          maxLines: 1,
          cursorColor: darkBlue,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              filled: true,
              fillColor: lightBlue.withOpacity(0.3),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.r))),
        ),
      ),
    );
  }
}
