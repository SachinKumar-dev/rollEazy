import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:roll_eazy/controllers/vehicle_controller/vehicle_controller.dart';
import 'package:roll_eazy/views/homepage/vehicle_details_screen.dart';
import '../../utility/widget_helper/widget_helper.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  final vehicle = Get.find<VehicleController>().vehicleCache;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context: context, value: 0.45),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
                itemCount: vehicle.length,
                itemBuilder: (context, index) {
                  final Vehicle = vehicle[index];
                  return GestureDetector(
                    onTap: (){
                      Get.find<VehicleController>().vehicleId.value=Vehicle.id;
                      print(Vehicle.id);
                      Get.to(()=> const MainScreen(),transition: Transition.rightToLeft);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height(context: context, value: 0.4),
                            width: width(context: context, value: 1),
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
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: styleText(
                                                text: Vehicle.vehicleName,
                                                txtColor: Colors.white,
                                                size: 14.sp),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: height(
                                                  context: context, value: 0.03),
                                              width:
                                                  width(context: context, value: 0.2),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white, width: 1),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xff233329),
                                                      Color(0xff3B4A42),
                                                      Color(0xff708871),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10.r)),
                                              child: Center(
                                                child: styleText(
                                                    text: '₹${Vehicle.pricePerHour}',
                                                    weight: FontWeight.w500,
                                                    size: 14.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 8.0.h, right: 10.w),
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: EdgeInsets.only(bottom: 25.h, left: 5.w),
                                  height: height(context: context, value: 0.044),
                                  width: width(context: context, value: 0.8),
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
                                      border:
                                          Border.all(color: Colors.white, width: 2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              AntDesign.setting_fill,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          styleText(text: Vehicle.gear, size: 15.sp),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              AntDesign.car_fill,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          styleText(
                                              text: Vehicle.seater.toString(),
                                              size: 15.sp),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.oil_barrel,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                          styleText(text: Vehicle.fuel, size: 15.sp),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Image positioned centrally
                          Positioned.fill(
                            bottom: height(context: context, value: 0.1),
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: width(context: context, value: 0.8),
                                height: height(context: context, value: 0.3),
                                child: Image.network(Vehicle.coverImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
  Widget sorryPage(){
    return Center(child: styleText(text: "Sorry no vehicles found!",txtColor: Colors.black),);
  }
}
