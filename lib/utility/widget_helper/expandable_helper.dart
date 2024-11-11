import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
import '../../controllers/vehicle_controller/vehicle_controller.dart';

class ExpandableHelper extends StatefulWidget {
  final String path;
  final String text;
  final int size;
  final Color colorText;

  const ExpandableHelper(
      {super.key,
      required this.path,
      required this.size,
      required this.colorText,
      required this.text});

  @override
  State<ExpandableHelper> createState() => _APPState();
}

class _APPState extends State<ExpandableHelper> {

  final ExpandableController _controller = ExpandableController();
  //fetch here ctrl nd its data
  //detailedVehicle
  final vehicleController = Get.find<VehicleController>();
  String text='';

  @override
  void initState() {
    //here the error is unable to fetch the data  null error ........
    final detailedVehicle = vehicleController.detailedVehicle.value!;
    print("data inside expandable helper initstate $detailedVehicle");
    setState(() {
      text=detailedVehicle.currentKm;
    });
    print("text is inside exp helper ${text}");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _controller,
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                // Toggle the expand/collapse state
                setState(() {
                  _controller.toggle();
                });
              },
              child: _buildListTile(
                controller: _controller,
                path: widget.path,
                title: styleText(
                    text: widget.text,
                    txtColor: widget.colorText,
                    size: widget.size.sp),
              )),
          Expandable(
            collapsed: Container(),
            expanded: customContainer(
                text:text
                 ),
          ),
        ],
      ),
    );
  }
}

// Expanded content container
Widget customContainer({required String text}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.green,
        width: 1,
      ),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        ),
        const SizedBox(height: 10),
        const Text("Add more content here if needed."),
      ],
    ),
  );
}

Widget _buildListTile(
    {required ExpandableController controller,
    required String path,
    required Widget title}) {
  return ListTile(
    leading: Image.asset(
      path,
      scale: 18.sp,
    ),
    title: title,
    trailing: Icon(
      controller.expanded
          ? Icons.arrow_downward // Icon when expanded
          : Icons.arrow_forward_ios, // Icon when collapsed
      color: Colors.red,
    ),
  );
}

//need to change the icon,spacing in whole ui
//response  based text changes need to be done later
// add google fonts of poppins too.....
//check the expandable color once matching or not