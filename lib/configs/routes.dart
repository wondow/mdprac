import 'package:feb25prac/views/screens/auth/dashboard.dart';
import 'package:feb25prac/views/screens/auth/home_screen.dart';
import 'package:feb25prac/views/screens/auth/login_screen.dart';
import 'package:feb25prac/views/screens/auth/signup_screen.dart';
import 'package:feb25prac/views/screens/auth/splash_screen.dart';
import 'package:feb25prac/views/screens/auth/cart.dart';
import 'package:feb25prac/views/screens/auth/orders.dart';

import 'package:get/get.dart';

var routes = [
  GetPage(name: "/", page: () => SplashScreen()),
  GetPage(name: "/signup", page: () => SignupScreen()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
  GetPage(name: "/dashboard", page: () => Dashboard()),
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/cart", page: () => const CartScreen()),
  GetPage(name: "/orders", page: () => const OrdersScreen()),
];
