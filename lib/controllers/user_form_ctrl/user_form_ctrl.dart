import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserFormController extends GetxController {
  //Text Controllers
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dob = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  //selected Gender
  String? gender = "Male";

  //selected drivingLicense
  String? license = "Yes";

  Future<void> registerUser() async {
    final dioClient = Dio();
    const url = 'http://172.168.0.157:9000/api/v1/users/register';

    try {
      final response = await dioClient.post(url, data: {
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

  Future<void> loginUser() async {
    final dioClient = Dio();
    const url = 'http://172.168.0.157:9000/api/v1/users/logIn';

    try {
      final response = await dioClient.post(url, data: {
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
}
