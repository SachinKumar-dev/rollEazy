import 'package:flutter/material.dart';
import 'package:roll_eazy/utility/widget_helper/widget_helper.dart';
class BengaluruPage extends StatefulWidget {
  const BengaluruPage({super.key});

  @override
  State<BengaluruPage> createState() => _BengaluruPageState();
}

class _BengaluruPageState extends State<BengaluruPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
        child: styleText(text: "Coming soon......",txtColor:Colors.black) ,
      ));

  }
}
