import 'package:feb25prac/configs/colors.dart';
import 'package:feb25prac/controllers/logincontroller.dart';
import 'package:feb25prac/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';

LoginController loginController = Get.put(LoginController());

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

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
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Email or Phone number",
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
                  child: Obx(
                    () => TextField(
                      controller: passwordController,
                      obscureText: !loginController.passwordVisible.value,
                      decoration: InputDecoration(
                        hintText: "Pin or Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            loginController.passwordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      onTap: () {
                        loginController.togglePassword();
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30),
                GestureDetector(
                  child: MaterialButton(
                    onPressed: () {
                      bool succes = loginController.login(
                        usernameController.text,
                        passwordController.text,
                      );
                      if (succes) {
                        Get.offAndToNamed("/homescreen");
                      } else {
                        Get.snackbar(
                          "Login failed",
                          "Please check you credentials",
                        );
                      }
                    },
                    color: Colors.white,
                    textColor: Colors.deepOrange,
                    child: Text("Login"),
                  ),
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
