import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../configs/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use Get.find() because the controller was already created on the Login screen!
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Join Us.",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 42),
                ),
                const SizedBox(height: 10),
                Text(
                  "Create your sanctuary account.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Name Fields (Side by side)
                Row(
                  children: [
                    Expanded(child: _buildTextField(context, "FIRST NAME", "Naila", LucideIcons.user, authController.firstNameController)),
                    const SizedBox(width: 15),
                    Expanded(child: _buildTextField(context, "LAST NAME", "Smith", null, authController.lastNameController)),
                  ],
                ),
                const SizedBox(height: 20),

                // Email Field
                _buildTextField(context, "EMAIL ADDRESS", "naila@example.com", LucideIcons.mail, authController.emailController, isEmail: true),
                const SizedBox(height: 20),

                // Password Field
                Text("PASSWORD", style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: AppTheme.textMain.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Obx(() => TextField(
                    controller: authController.passwordController,
                    obscureText: authController.isPasswordHidden.value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "••••••••",
                      hintStyle: TextStyle(color: AppTheme.textVariant.withOpacity(0.5)),
                      prefixIcon: const Icon(LucideIcons.lock, color: AppTheme.textVariant),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.isPasswordHidden.value ? LucideIcons.eyeOff : LucideIcons.eye,
                          color: AppTheme.textVariant,
                        ),
                        onPressed: authController.togglePassword,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  )),
                ),
                const SizedBox(height: 40),

                // Signup Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Obx(() => ElevatedButton(
                    onPressed: authController.isLoading.value ? null : () => authController.signup(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      shadowColor: AppTheme.primary.withOpacity(0.3),
                    ),
                    child: authController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text("Create Account", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white, fontSize: 16)),
                  )),
                ),
                const SizedBox(height: 30),

                // Switch back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? ", style: Theme.of(context).textTheme.bodyMedium),
                    GestureDetector(
                      onTap: () => Get.back(), // Pops the signup screen to reveal login
                      child: Text(
                        "Sign in.",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to keep code clean
  Widget _buildTextField(BuildContext context, String label, String hint, IconData? icon, TextEditingController controller, {bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: AppTheme.textMain.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4))],
          ),
          child: TextField(
            controller: controller,
            keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppTheme.textVariant.withOpacity(0.5)),
              prefixIcon: icon != null ? Icon(icon, color: AppTheme.textVariant) : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            ),
          ),
        ),
      ],
    );
  }
}