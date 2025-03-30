import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user_form_ctrl/global_user.dart';

class AuthService extends GetxService {
  int selectedIndex = 0;
  static const String _loginKey = 'isLoggedIn';

    Future<void> login() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginKey, true);
    }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, false);
    Get.find<GlobalUserController>().clearUser();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

}