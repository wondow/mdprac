import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'auth_controller.dart';

class ProfileController extends GetxController {
  final ApiService _api = ApiService();
  var isLoading = false.obs;

  // Profile Edit Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Password Controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isPasswordHidden = true.obs;

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;

  // Prefill data when opening the edit sheet
  // Prefill data when opening the edit sheet
  void prefillData() {
    final auth = Get.find<AuthController>();
    final user = auth.currentUser.value; // Added .value!

    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone == 'No phone provided'
        ? ''
        : user!.phone;
    addressController.text = user?.address == 'No address provided'
        ? ''
        : user!.address.replaceAll(', Nairobi', '');
  }

  Future<void> updateProfile() async {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Name cannot be empty');
      return;
    }

    isLoading.value = true;
    try {
      // Split name into first and last
      List<String> names = nameController.text.trim().split(' ');
      String firstName = names[0];
      String lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final response = await _api.post('update_profile.php', {
        'firstname': firstName,
        'lastname': lastName,
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'city': 'Nairobi', // Defaulting to Nairobi for now
      });

      if (response.data['success'] == true) {
        Get.back(); // Close bottom sheet
        Get.snackbar(
          'Success',
          response.data['message'],
          backgroundColor: Colors.green[100],
        );
        // Refresh user data globally
        await Get.find<AuthController>().checkLoginStatus();
      } else {
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'New passwords do not match',
        backgroundColor: Colors.red[100],
      );
      return;
    }
    if (newPasswordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red[100],
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post('change_password.php', {
        'current_password': currentPasswordController.text,
        'new_password': newPasswordController.text,
      });

      if (response.data['success'] == true) {
        Get.back(); // Close sheet
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.snackbar(
          'Success',
          response.data['message'],
          backgroundColor: Colors.green[100],
        );
      } else {
        Get.snackbar(
          'Error',
          response.data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to change password');
    } finally {
      isLoading.value = false;
    }
  }
}
