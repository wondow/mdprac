import 'package:feb25prac/views/screens/auth/dashboard.dart';
import 'package:feb25prac/views/screens/auth/home_screen.dart';
import 'package:feb25prac/views/screens/auth/login_screen.dart';
import 'package:feb25prac/views/screens/auth/signup_screen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignupScreen()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
  GetPage(name: "/dashboard", page: () => Dashboard()),
];
