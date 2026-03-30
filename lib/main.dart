import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:feb25prac/configs/routes.dart';
import 'package:feb25prac/configs/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize local storage

  runApp(
    GetMaterialApp(
      title: 'Digital Sanctuary',
      initialRoute: "/",
      getPages: routes,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    ),
  );
}