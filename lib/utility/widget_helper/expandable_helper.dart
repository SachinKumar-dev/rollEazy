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
  final String expandText;

  const ExpandableHelper(
      {super.key,
      required this.path,
      required this.expandText,
      required this.size,
      required this.colorText,
      required this.text});

  @override
  State<ExpandableHelper> createState() => _APPState();
}

class _APPState extends State<ExpandableHelper> {

  final ExpandableController _controller = ExpandableController();
  final vehicleController = Get.find<VehicleController>();

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
                context:context,
                text:widget.expandText
                 ),
          ),
        ],
      ),
    );
  }
}

// Expanded content container
Widget customContainer({required String text,required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: height(context: context,value: 0.1),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        ),
        // const SizedBox(height: 10),
        // const Text("Add more content here if needed."),
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