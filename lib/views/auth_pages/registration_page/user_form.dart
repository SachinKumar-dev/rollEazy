// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:roll_eazy/controllers/user_form_ctrl/image_ctrl.dart';
// import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
// import 'package:roll_eazy/utility/color_helper/color_helper.dart';
// import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
//
// class UserForm extends StatefulWidget {
//   const UserForm({super.key});
//
//   @override
//   State<UserForm> createState() => _UserFormState();
// }
//
// class _UserFormState extends State<UserForm> {
//   final FocusNode _focusNodeOne = FocusNode();
//   final FocusNode _focusNodeTwo = FocusNode();
//   final FocusNode _focusNodeThree = FocusNode();
//
//   final ImageController controller = Get.find();
//   final UserFormController userForm = Get.find();
//
//   // List of items in the dropdown
//   final List<String> _genderItems = ['Male', 'Female', 'Others'];
//   final List<String> _licenseItems = ['Yes', 'No'];
//
//   void _showDropdownMenu(List<String> items, TextEditingController ctrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: items.map((String value) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: Text(
//                   value,
//                   style: GoogleFonts.poppins(),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     ctrl.text = value;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNodeOne.dispose();
//     _focusNodeTwo.dispose();
//     _focusNodeThree.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         child: GetBuilder<UserFormController>(
//           autoRemove: false,
//           assignId: true,
//           builder: (ctrl) {
//             return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: SafeArea(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: EdgeInsets.symmetric(
//                                   vertical:
//                                       height(context: context, value: 0.015),
//                                   horizontal:
//                                       width(context: context, value: 0.015)),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: greenTextColor),
//                               child: IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(
//                                     Icons.arrow_back,
//                                     color: Colors.white,
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: styleText(
//                                 text: "Create New Details",
//                                 txtColor: txtGreyShade,
//                                 weight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       Stack(
//                         children: [
//                           Image.asset("assets/logos/UserForm.png"),
//                           Positioned(
//                             top: height(context: context, value: 0.05),
//                             left: width(context: context, value: 0.045),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 txtFormField(
//                                     type: TextInputType.name,
//                                     context: context,
//                                     text: "Full Name",
//                                     textType: ctrl.userName),
//                                 SizedBox(
//                                   height:
//                                       height(context: context, value: 0.035),
//                                 ),
//                                 txtFormField(
//                                     length: 10,
//                                     type: TextInputType.number,
//                                     context: context,
//                                     text: "Mobile Number",
//                                     textType: ctrl.mobileNumber),
//                                 SizedBox(
//                                   height:
//                                       height(context: context, value: 0.035),
//                                 ),
//                                 SizedBox(
//                                   height: height(context: context, value: 0.07),
//                                   width: width(context: context, value: 0.9),
//                                   child: TextField(
//                                     onTap: () async {
//                                       _focusNodeOne.requestFocus();
//                                       final DateTime? selected =
//                                           await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(1900, 1, 1),
//                                         lastDate: DateTime.now(),
//                                       );
//                                       if (selected != null) {
//                                         String formatedDate =
//                                             DateFormat('dd-MM-yyyy')
//                                                 .format(selected);
//                                         ctrl.dob.text = formatedDate.toString();
//                                       }
//                                     },
//                                     focusNode: _focusNodeOne,
//                                     readOnly: true,
//                                     controller: ctrl.dob,
//                                     cursorColor: greenTextColor,
//                                     decoration: InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: "DOB as per Aadhar",
//                                       hintStyle: GoogleFonts.poppins(
//                                           fontSize: 15.sp, color: Colors.grey),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.r),
//                                         borderSide: const BorderSide(
//                                             color: Colors.white, width: 1),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.r),
//                                         borderSide: BorderSide(
//                                             color: greenTextColor, width: 2),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       height(context: context, value: 0.035),
//                                 ),
//                                 SizedBox(
//                                   height: height(context: context, value: 0.07),
//                                   width: width(context: context, value: 0.9),
//                                   child: TextField(
//                                     onTap: () {
//                                       _focusNodeTwo.requestFocus();
//                                       _showDropdownMenu(
//                                           _genderItems, ctrl.gender);
//                                     },
//                                     focusNode: _focusNodeTwo,
//                                     readOnly: true,
//                                     controller: ctrl.gender,
//                                     cursorColor: greenTextColor,
//                                     decoration: InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: "Gender",
//                                       hintStyle: GoogleFonts.poppins(
//                                           fontSize: 15.sp, color: Colors.grey),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.r),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey, width: 1),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.r),
//                                         borderSide: BorderSide(
//                                             color: greenTextColor, width: 2),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       height(context: context, value: 0.035),
//                                 ),
//                                 SizedBox(
//                                   height: height(context: context, value: 0.07),
//                                   width: width(context: context, value: 0.9),
//                                   child: TextField(
//                                     onTap: () {
//                                       _focusNodeThree.requestFocus();
//                                       _showDropdownMenu(
//                                           _licenseItems, ctrl.license);
//                                     },
//                                     focusNode: _focusNodeThree,
//                                     readOnly: true,
//                                     controller: ctrl.license,
//                                     cursorColor: greenTextColor,
//                                     decoration: InputDecoration(
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       hintText: "Driving License",
//                                       hintStyle: GoogleFonts.poppins(
//                                           fontSize: 15.sp, color: Colors.grey),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.r),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey, width: 1),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.r),
//                                         borderSide: BorderSide(
//                                             color: greenTextColor, width: 2),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(9.0),
//                           child: DottedBorder(
//                             color: Colors.grey,
//                             strokeWidth: 1.5,
//                             dashPattern: const [8, 4],
//                             borderType: BorderType.RRect,
//                             radius: Radius.circular(8.r),
//                             child: Container(
//                               height: height(context: context, value: 0.15),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade50,
//                                 borderRadius: BorderRadius.circular(8.r),
//                               ),
//                               child: Obx(
//                                 () => IconButton(
//                                   onPressed: () {
//                                     controller.imagePicker();
//                                   },
//                                   icon: Icon(
//                                     Icons.image,
//                                     color: controller.isImageSelected.value
//                                         ? greenTextColor
//                                         : Colors.red,
//                                     size: 40,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: height(context: context, value: 0.05),
//                       ),
//                       Card(
//                         elevation: 1,
//                         child: Container(
//                           height: height(context: context, value: 0.063),
//                           width: width(context: context, value: 0.9),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: greenTextColor.withOpacity(0.5),
//                                 spreadRadius: -25,
//                                 // How much the shadow spreads
//                                 blurRadius: 10,
//                                 // Softness of the shadow
//                                 offset: const Offset(-5, 27),
//                               ),
//                             ],
//                           ),
//                           child: ElevatedButton(
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                       WidgetStateProperty.all(greenTextColor),
//                                   shape: WidgetStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(8.0.r),
//                                     ),
//                                   )),
//                               onPressed: () {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                                 ctrl.formValidations();
//                               },
//                               child: styleText(
//                                   text: "Next Step",
//                                   txtColor: Colors.white,
//                                   size: textSize(value: 15.sp),
//                                   weight: FontWeight.w500)),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(
//                             MediaQuery.of(context).size.width * 0.06),
//                         child: StepProgressIndicator(
//                           roundedEdges: Radius.circular(20.r),
//                           totalSteps: 3,
//                           currentStep: 1,
//                           selectedColor: greenTextColor,
//                           unselectedColor: Colors.grey,
//                         ),
//                       ),
//                     ])));
//           },
//         ),
//       ),
//     );
//   }
// }
