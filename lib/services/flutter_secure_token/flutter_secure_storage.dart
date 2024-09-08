import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SecureToken extends GetxController {
  final FlutterSecureStorage secStorage = const FlutterSecureStorage();

  //method to write token
  Future<void> saveToken(String accessToken) async {
    await secStorage.write(key: "Access Token", value: accessToken);
  }

  //method to read token
  Future<String?> getToken() async {
    return await secStorage.read(key: "Access Token");
  }

  //setup Req to add access token to header
  Dio dio = Dio();

  Future<void> setupDio() async {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await getToken(); // Retrieve the token
        if (token != null) {
          options.headers['Authorization'] =
              'Bearer $token'; // Add token to the header
        }
        return handler.next(options);
      },
    ));
  }
}
