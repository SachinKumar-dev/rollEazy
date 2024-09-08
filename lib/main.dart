import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/splash_screen/splash_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Get.put(ApiServices());
  Get.put(UserFormController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: greenTextColor),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
