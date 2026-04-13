import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart'; // Make sure Dio is imported for the error catcher!
import '../services/api_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var currentUser = Rxn<UserModel>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  // --- STARTUP CHECK ---
  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    String? token = await _storage.read(key: 'token');
    if (token != null) {
      try {
        final response = await _api.get('user.php');
        if (response.data != null && response.data['success'] == true) {
          currentUser.value = UserModel.fromJson(response.data['user'], token);
          Get.offAllNamed('/dashboard');
          return;
        }
      } catch (e) {
        print("Failed to fetch user: $e");
      }
    }

    Get.offAllNamed('/login');
  }

  // --- LOGIN ---
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

      // 1. Check if the response is valid JSON
      if (response.data == null || response.data is String) {
        print("RAW PHP OUTPUT: ${response.data}");
        Get.snackbar(
          'Server Error',
          'PHP printed a raw error. Check debug console.',
          backgroundColor: Colors.red[100],
        );
        return;
      }

      // 2. Process valid response
      if (response.data['success'] == true) {
        String token = response.data['token'];
        await _storage.write(key: 'token', value: token);
        currentUser.value = UserModel.fromJson(response.data['user'], token);

        emailController.clear();
        passwordController.clear();
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Login Failed',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } on DioException catch (e) {
      // 3. CATCH THE FORMAT EXCEPTION AND PRINT THE RAW HTML ERROR
      print("--- DIO ERROR ---");
      print(e.message);
      print("RAW SERVER RESPONSE: ${e.response?.data}");
      Get.snackbar(
        'Network Error',
        'Check debug console for PHP error.',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- SIGNUP ---
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

      // 1. Check if response is valid JSON
      if (response.data == null || response.data is String) {
        print("RAW PHP OUTPUT: ${response.data}");
        Get.snackbar(
          'Server Error',
          'PHP printed a raw error. Check debug console.',
          backgroundColor: Colors.red[100],
        );
        return;
      }

      // 2. Process valid response (Signup does NOT return a token, it just routes to login!)
      if (response.data['success'] == true) {
        Get.snackbar(
          'Success',
          'Account created! Please login.',
          backgroundColor: Colors.green[100],
        );
        Get.offNamed('/login');
      } else {
        Get.snackbar(
          'Signup Failed',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } on DioException catch (e) {
      // 3. CATCH THE FORMAT EXCEPTION AND PRINT
      print("--- DIO ERROR ---");
      print(e.message);
      print("RAW SERVER RESPONSE: ${e.response?.data}");
      Get.snackbar(
        'Network Error',
        'Check debug console for PHP error.',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- LOGOUT ---
  Future<void> logout() async {
    await _storage.delete(key: 'token');
    currentUser.value = null;
    Get.offAllNamed('/login');
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
