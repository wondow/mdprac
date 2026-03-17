import 'package:feb25prac/configs/colors.dart';
import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightTextFeildStyle() {
    return TextStyle(
      color: colorText,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiboldTextFeildStyle(){
    return TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  );
  }
}
