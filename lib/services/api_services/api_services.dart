import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiServices extends GetxController {
  // Get the base URL from the .env file
  static String get baseUrl => dotenv.env['SERVER_URL']!;
  //put multiple routes here and access as per route needs

  //Login
  String getLogInUrl() {
    return '$baseUrl/api/v1/users/logIn';
  }

  //Register
  String getRegisterUrl() {
    return '$baseUrl/api/v1/users/register';
  }

  //Send otp?
  String getSendOtpUrl() {
    return '$baseUrl/api/v1/users/sendVerification';
  }

  //Reset password
  String getResetPasswordUrl() {
    return '$baseUrl/api/v1/users/resetPass';
  }

  //secureRoute
  String getSecureRoutedUrl() {
    return '$baseUrl/api/v1/users/secureRoute';
  }

  //deleteAccount
  String getDeleteAccountRoutedUrl() {
    return '$baseUrl/api/v1/users/deleteAccount';
  }

  //verify email before registration
  String getEmailVerificationUrl() {
    return '$baseUrl/api/v1/users/VerifyOtpWhileRegistering';
  }

  //resend otp
  String getResendOTPUrl() {
    return '$baseUrl/api/v1/users/resendOtp';
  }

  //updateDetails
  String getUpdateProfileUrl() {
    return '$baseUrl/api/v1/users/updateUserDetails';
  }

  /*------------------------------------------------Vehicle Routes-----------------------------*/

  //get all vehicles
  String getAllVehicleUrl() {
    return '$baseUrl/api/v1/veichle/getAllVeichles';
  }

  //get detailed vehicle data
  String getDetailedVehicleUrl() {
    return '$baseUrl/api/v1/veichle/getVeichle';
  }



}
