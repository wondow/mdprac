import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';
import '../configs/routes.dart'; // We will fix routes next!

class AuthController extends GetxController {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  UserModel? currentUser;

  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  // Check if user is already logged in when app starts
  Future<void> checkLoginStatus() async {
    String? token = await _storage.read(key: 'token');
    if (token != null) {
      Get.offAllNamed('/dashboard');
    }
  }

  // Handle Login
  // Handle Login
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red[100],
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post('auth.php?action=login', {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      print("PHP Response: ${response.data}"); // <-- ADDED THIS FOR DEBUGGING

      if (response.data['success'] == true) {
        currentUser = UserModel.fromJson(
          response.data['user'],
          response.data['token'],
        );
        await _storage.write(key: 'token', value: response.data['token']);

        Get.offAllNamed('/dashboard');
        emailController.clear();
        passwordController.clear();
      } else {
        Get.snackbar(
          'Login Failed',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      print("Dio Error: $e"); // <-- ADDED THIS TO SEE THE EXACT ERROR
      Get.snackbar(
        'Error',
        'Could not connect to server',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Handle Signup
  Future<void> signup() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red[100],
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post('auth.php?action=register', {
        'firstname': firstNameController.text.trim(),
        'lastname': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      print("PHP Response: ${response.data}"); // <-- ADDED THIS FOR DEBUGGING

      if (response.data['success'] == true) {
        // 1. Get the token from PHP
        String token = response.data['token'];

        // 2. AWAIT the secure save (This is critical!)
        await _storage.write(key: 'token', value: token);

        // 3. Verify it saved just for our sanity
        String? savedToken = await _storage.read(key: 'token');
        print("VERIFIED SAVED TOKEN: $savedToken");

        currentUser = UserModel.fromJson(response.data['user'], token);

        emailController.clear();
        passwordController.clear();

        // 4. Now navigate
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Signup Failed',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      print("Dio Error: $e"); // <-- ADDED THIS TO SEE THE EXACT ERROR
      Get.snackbar(
        'Error',
        'Could not connect to server',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Secure Logout
  Future<void> logout() async {
    await _storage.delete(key: 'token'); // Delete the token from the phone
    currentUser = null; // Wipe user data
    Get.offAllNamed('/login'); // Send them to the login screen
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
