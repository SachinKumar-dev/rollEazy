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

  // Update specific fields of the user and save changes
  void updateUser(Map<String, dynamic> updatedFields) {
    if (user.value != null) {
      // Convert user to a Map, update fields, and recreate User object
      Map<String, dynamic> currentUser = user.value!.toJson();
      updatedFields.forEach((key, value) {
        if (currentUser.containsKey(key)) {
          currentUser[key] = value;
        }
      });

      user.value = User.fromJson(currentUser); // Update reactive user
      storage.write('user', jsonEncode(user.value!.toJson())); // Persist to storage
      //print("updated user is ${storage.read("user")}");
    } else {
      //print("No user is currently logged in to update.");
    }
  }

  //set guest
  void setGuestMode(){
    storage.write("isGuest", true);
  }

  //get guest
  bool getGuest(){
   final guestLogin= storage.read("isGuest");
   return guestLogin;
  }

  //set as non guest during login
  void setNonGuest(){
    storage.write("isGuest",false);
  }

}
