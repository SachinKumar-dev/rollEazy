import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';

class ReviewMainpage extends StatefulWidget {
  const ReviewMainpage({super.key});

  @override
  State<ReviewMainpage> createState() => _ReviewMainpageState();
}

class _ReviewMainpageState extends State<ReviewMainpage> {
  final userCtrl = Get.find<GlobalUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FutureBuilder(future: future, builder: builder),
    );
  }
}
