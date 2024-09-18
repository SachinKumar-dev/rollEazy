import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/profile_page/profile_view.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalUserController loggedInUser = Get.find<GlobalUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(AntDesign.share_alt_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(EvaIcons.edit_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              height: height(context: context, value: 0.27),
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
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
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 18.h, top: 18.h),
                        height: height(context: context, value: 0.15),
                        width: width(context: context, value: 0.32),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: ClipOval(
                          child: Obx(() {
                            return Image.network(
                              loggedInUser.user.value?.profileImage ??
                                  "https://cdn-icons-png.flaticon.com/128/16385/16385147.png",
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.08),
                        child: styleText(
                            text: "Sachin Kumar",
                            txtColor: Colors.white,
                            size: 16.5.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            styleText(text: "Trips", size: 14.sp),
                            styleText(text: "0", size: 14.sp),
                          ],
                        ),
                        SizedBox(
                          width: width(context: context, value: 0.05),
                        ),
                        Column(
                          children: [
                            styleText(text: "Journey", size: 14.sp),
                            styleText(text: "0", size: 14.sp),
                          ],
                        ),
                        SizedBox(
                          width: width(context: context, value: 0.05),
                        ),
                        Column(
                          children: [
                            styleText(text: "Ratings", size: 14.sp),
                            styleText(text: "0", size: 14.sp),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height(context: context, value: 0.03),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                GestureDetector(
                  onTap: () {
                    print(MediaQuery
                        .of(context)
                        .size
                        .height);
                    print(MediaQuery
                        .of(context)
                        .size
                        .width);
                  },
                  child: _buildListTile(
                    icon: Iconsax.car_outline,
                    title: styleText(
                        text: "Rides", txtColor: txtGreyShade, size: 16.sp),
                  ),
                ),
                const Divider(),
                _buildListTile(
                  icon: Iconsax.location_add_outline,
                  title: styleText(
                      text: "Address", txtColor: txtGreyShade, size: 16.sp),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Get.to((const ProfileView()),
                        transition: Transition.rightToLeft);
                  },
                  child: _buildListTile(
                    icon: Icons.person_3_outlined,
                    title: styleText(
                        text: "Profile", txtColor: txtGreyShade, size: 16.sp),
                  ),
                ),
                const Divider(),
                _buildListTile(
                  icon: Icons.attach_money_rounded,
                  title: styleText(
                      text: "Refunds", txtColor: txtGreyShade, size: 16.sp),
                ),
                const Divider(),
                _buildListTile(
                  icon: Icons.info_outline,
                  title: styleText(
                      text: "General Info",
                      txtColor: txtGreyShade,
                      size: 16.sp),
                ),
                const Divider(),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()async{
             await Get.find<UserFormController>().logOut();
            },
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
              height: height(context: context, value: 0.05),
              width: width(context: context, value: 0.235),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Center(
                  child: styleText(
                      text: "Log Out",
                      txtColor: Colors.red,
                      size: 15.sp,
                      weight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required Widget title}) {
    return ListTile(
      leading: Icon(
        icon,
        color: greenTextColor,
        size: 17.sp,
      ),
      title: title,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.red,
        size: 15.sp,
      ),
    );
  }
}
