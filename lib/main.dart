import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roll_eazy/controllers/navigation_ctrl/nav_ctrl.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/image_ctrl.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/user_form_ctrl.dart';
import 'package:roll_eazy/controllers/vehicle_controller/vehicle_controller.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:roll_eazy/services/flutter_secure_token/flutter_secure_storage.dart';
import 'package:roll_eazy/logIn_screen.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/auth_pages/registration_page/user_form_screen.dart';
import 'package:roll_eazy/views/homepage/home_screen.dart';
import 'package:roll_eazy/views/landing_page/landing_page.dart';
import 'package:roll_eazy/views/profile_page/profile_page.dart';
import 'package:roll_eazy/views/reviews_page/ReviewPage.dart';
import 'package:roll_eazy/views/splash_screen/splash_screen.dart';
import 'controllers/user_form_ctrl/global_user.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Get.put(ApiServices());
  await GetStorage.init();
  await Get.put(AuthService()).isLoggedIn();
  Get.put(GlobalUserController());
  await Get.put(VehicleController().getAllVehicles());
  Get.put(VehicleController());
  Get.put(UserFormController());
  Get.put(ImageController());
  Get.put(SecureToken());
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
