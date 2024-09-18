import 'package:get/get.dart';
import '../../models/user_model/user_model.dart';

class GlobalUserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  //set user data
  void setUser(User loggedInUser) {
    user.value = loggedInUser;
  }

  //clear user data or logout
  void clearUser() {
    user.value = null;
  }
}
