import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SecureToken extends GetxController {
  final FlutterSecureStorage secStorage = const FlutterSecureStorage();

  //method to write token
  Future<void> saveAccessToken(String accessToken) async {
    await secStorage.write(key: "Access Token", value: accessToken);
  }

  //method to write token
  Future<void> saveRefreshToken(String refreshToken) async {
    await secStorage.write(key: "Refresh Token", value: refreshToken);
  }

  //method to read token
  Future<String?> getRToken() async {
    return await secStorage.read(key: "Refresh Token");
  }

  //method to read token
  Future<String?> getToken() async {
    return await secStorage.read(key: "Access Token");
  }

  //delete token
  Future<void>deleteToken()async{
    await secStorage.delete(key: "Access Token");
  }

}
