import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiServices extends GetxController {
  // Get the base URL from the .env file
  static String get baseUrl => dotenv.env['SERVER_URL']!;
  //put multiple routes here and access as per route needs

  //Login
  String getLogInUrl() {
    return '$baseUrl/logIn';
  }

  //Register
  String getRegisterUrl() {
    return '$baseUrl/register';
  }

  //User Exist?
  String getValidUserUrl() {
    return '$baseUrl/isUserExist';
  }

  //User Exist?
  String getResetPasswordUrl() {
    return '$baseUrl/sendVerification';
  }
}
