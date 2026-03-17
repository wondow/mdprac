import 'package:feb25prac/configs/colors.dart';
import 'package:feb25prac/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFFAF6384),
        title: Text(
          "Welcome to the Login page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  "Winx",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 70, 16, 164),
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset('assets/images/winx.png', height: 200, width: 200),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Username",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.gradient_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email or phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.white,
                    textColor: Colors.deepOrange,
                    child: Text("Login"),
                  ),
                  onTap: () {
                    Get.offAndToNamed(
                      "/lib/views/screens/auth/home_screen.dart",
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },

                    color: Colors.deepOrange,
                    textColor: Colors.black,

                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),

                        child: Container(
                          height: 20,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Sign up",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
