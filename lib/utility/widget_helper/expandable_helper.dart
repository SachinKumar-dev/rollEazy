import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
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
            expanded:
            customContainer(context: context, text: widget.expandText),
          ),
        ],
      ),
    );
  }
}

// Expanded content container
Widget customContainer({required String text, required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: height(context: context, value: 0.1),
    decoration: BoxDecoration(
      color: lightBlue.withOpacity(0.7),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 15.sp,color: Colors.white),
        ),
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
          ? Icons.arrow_downward
          : Icons.arrow_forward_ios,size: 16,
      color: Colors.red,
    ),
  );
}