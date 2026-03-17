import 'package:feb25prac/configs/routes.dart';
import 'package:feb25prac/views/screens/auth/dashboard.dart';
// ignore: unused_import
import 'package:feb25prac/views/screens/auth/orders.dart';
// ignore: unused_import
import 'package:feb25prac/views/screens/auth/proflie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: Dashboard(),

      debugShowMaterialGrid: false,
    ),
  );
}
