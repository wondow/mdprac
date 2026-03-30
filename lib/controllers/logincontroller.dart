import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var passwordVisible = false.obs;
  // ignore: strict_top_level_inference
  login(user, pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "admin" && password.value == "12345") {
      return true;
    } else {
      return false;
    }
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }
}
