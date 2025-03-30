import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import 'package:roll_eazy/views/general_page_info/general_info.dart';
import 'package:roll_eazy/views/profile_page/profile_view.dart';
import 'package:roll_eazy/views/refund_page/refund_page.dart';
import 'package:roll_eazy/views/ride_details/all_rides_page.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalUserController loggedInUser = Get.find<GlobalUserController>();
  final String appName = "Roll Eazy";
  final String playStoreUrl = "https://play.google.com/store/apps/details?id=com.roll_eazy.app";


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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(EvaIcons.edit_outline, color: Colors.black),
              onPressed: () {
                Get.to(() => const ProfileView(),
                    transition: Transition.rightToLeft);
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Obx(() {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    height: height(context: context, value: 0.27),
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          lightBlue.withOpacity(0.5),
                          darkBlue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: height(context: context, value: 0.15),
                                width: width(context: context, value: 0.32),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: loggedInUser
                                            .user.value?.profileImage ??
                                        "https://cdn-icons-png.flaticon.com/128/16385/16385147.png",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 55.w),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    styleText(
                                      text: "Total Trips",
                                      size: 18.sp,
                                    ),
                                    styleText(
                                      text: loggedInUser
                                              .user.value?.totalTrips
                                              .toString() ??
                                          "0",
                                      size: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // User Name
                          SizedBox(height: 8.h),
                          Container(
                            margin: EdgeInsets.only(left: 20.w, top: 10.h),
                            child: styleText(
                              text: loggedInUser.user.value?.userName ??
                                  "Rider",
                              txtColor: Colors.white,
                              size: 16.5.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height(context: context, value: 0.01)),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const CompletedRidesPage(),
                              transition: Transition.rightToLeft);
                        },
                        child: _buildListTile(
                          icon: Iconsax.car_outline,
                          title: styleText(
                              text: "Rides",
                              txtColor: txtGreyShade,
                              size: 16.sp),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Get.to(const ProfileView(),
                              transition: Transition.rightToLeft);
                        },
                        child: _buildListTile(
                          icon: Icons.person_3_outlined,
                          title: styleText(
                              text: "Profile",
                              txtColor: txtGreyShade,
                              size: 16.sp),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Get.to(const RefundPage(),
                              transition: Transition.rightToLeft);
                        },
                        child: _buildListTile(
                          icon: Icons.attach_money_rounded,
                          title: styleText(
                              text: "Refunds",
                              txtColor: txtGreyShade,
                              size: 16.sp),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: ()async{
                          await Share.share(
                            "Check out this amazing vehicle rental app $appName! Download it here: $playStoreUrl",
                            subject: "Download $appName from the Play Store",
                          );
                        },
                        child: _buildListTile(
                          icon: Icons.share,
                          title: styleText(
                              text: "Share",
                              txtColor: txtGreyShade,
                              size: 16.sp),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Get.to(const GeneralInfo(),
                              transition: Transition.rightToLeft);
                          // Get.dialog(const ReviewPage());
                        },
                        child: _buildListTile(
                          icon: Icons.info_outline,
                          title: styleText(
                              text: "General Info",
                              txtColor: txtGreyShade,
                              size: 16.sp),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                // Logout Button
                GestureDetector(
                  onTap: () async {
                    await Get.find<UserFormController>().logOut();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    height: height(context: context, value: 0.05),
                    width: width(context: context, value: 0.235),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Center(
                      child: styleText(
                        text: "Log Out",
                        txtColor: Colors.red,
                        size: 15.sp,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required Widget title}) {
    return ListTile(
      leading: Icon(icon, color: darkBlue, size: 17.sp),
      title: title,
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 15.sp),
    );
  }
}
