import 'package:feb25prac/configs/routes.dart';
import 'package:feb25prac/views/screens/auth/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),

      debugShowMaterialGrid: false,
    ),
  );
}
