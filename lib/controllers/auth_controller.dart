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

      if (response.data['success'] == true) {
        // Save user and token
        currentUser = UserModel.fromJson(
          response.data['user'],
          response.data['token'],
        );
        await _storage.write(key: 'token', value: response.data['token']);

        Get.offAllNamed('/dashboard');

        // Clear text fields
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

      if (response.data['success'] == true) {
        Get.snackbar(
          'Success',
          'Account created! Please login.',
          backgroundColor: Colors.green[100],
        );
        Get.offNamed('/login'); // Go back to login screen
      } else {
        Get.snackbar(
          'Signup Failed',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not connect to server',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
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
