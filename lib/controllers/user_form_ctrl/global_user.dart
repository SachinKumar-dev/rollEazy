import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/user_model/user_model.dart';

class GlobalUserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  //loads user data upon app startup
  void _loadUser() {
    String? userData = storage.read('user');
    if (userData != null) {
      user.value = User.fromJson(jsonDecode(userData));
    }
  }

  // Set user data and save to GetStorage
  void setUser(User loggedInUser) {
    user.value = loggedInUser;
    storage.write('user', jsonEncode(loggedInUser.toJson()));
  }

  // Clear user data from state and GetStorage
  void clearUser() {
    user.value = null;
    storage.remove('user');
  }

}
