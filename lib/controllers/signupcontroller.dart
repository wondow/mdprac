import 'package:get/get.dart';

class Signupcontroller extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var passwordVisible = false.obs;
  
  // ignore: strict_top_level_inference
  signup(user, pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "mine" && password.value == "qwe45") {
      return true;
    } else {
      return false;
    }
  }



   void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }
}
