import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiServices extends GetxController {
  // Get the base URL from the .env file
  static String get baseUrl => dotenv.env['USER_SERVER_URL']!;
  static String get vehicleUrl => dotenv.env['VEHICLE_SERVER_URL']!;
  //put multiple routes here and access as per route needs

  //Login
  String getLogInUrl() {
    return '$baseUrl/logIn';
  }

  //Register
  String getRegisterUrl() {
    return '$baseUrl/register';
  }

  //Send otp?
  String getSendOtpUrl() {
    return '$baseUrl/sendVerification';
  }

  //Reset password
  String getResetPasswordUrl() {
    return '$baseUrl/resetPass';
  }

  //secureRoute
  String getSecureRoutedUrl() {
    return '$baseUrl/secureRoute';
  }

  //deleteAccount
  String getDeleteAccountRoutedUrl() {
    return '$baseUrl/deleteAccount';
  }

  //verify email before registration
  String getEmailVerificationUrl() {
    return '$baseUrl/VerifyOtpWhileRegistering';
  }

  //resend otp
  String getResendOTPUrl() {
    return '$baseUrl/resendOtp';
  }

  //updateDetails
  String getUpdateProfileUrl() {
    return '$baseUrl/updateUserDetails';
  }

  /*------------------------------------------------Vehicle Routes-----------------------------*/

  //get all vehicles
  String getAllVehicleUrl() {
    return '$vehicleUrl/getAllVeichles';
  }

  //get detailed vehicle data
  String getDetailedVehicleUrl() {
    return '$vehicleUrl/getVeichle';
  }



}
