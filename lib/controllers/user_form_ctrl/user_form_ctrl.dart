import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';

class UserFormController extends GetxController {
  final url = Get.find<ApiServices>();
  final dioClient = Dio();

  //Text Controllers
  final TextEditingController userName = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();

  final TextEditingController resetEmail = TextEditingController();
  final TextEditingController OTP = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  //userName

  //selected Gender
  String? gender = "Male";

  //selected drivingLicense
  String? license = "Yes";

  Future<void> registerUser() async {
    final registerUrl = url.getRegisterUrl();

    try {
      final response = await dioClient.post(registerUrl, data: {
        'userName': userName.text,
        'email': email.text,
        'password': password.text,
        'gender': gender,
        'license': license,
        'dob': dob.text,
        'mobileNumber': mobileNumber.text,
      });

      if (response.statusCode == 201) {
        print('User registered successfully: ${response.data}');
      } else {
        print('Failed to register user. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed with error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> loginUser() async {
    final logInUrl = url.getLogInUrl();
    try {
      final response = await dioClient.post(logInUrl, data: {
        'email': email.text,
        'password': password.text,
      });

      if (response.statusCode == 201) {
        print('User registered successfully: ${response.data}');
      } else {
        print('Failed to register user. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed with error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  //check jwt api
}
