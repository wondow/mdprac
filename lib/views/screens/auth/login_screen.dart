import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../configs/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller once
    final authController = Get.put(AuthController());

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
                  "Welcome Back.",
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 42),
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter your sanctuary.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 50),

                // Email Field
                Text(
                  "EMAIL ADDRESS",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.textMain.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: authController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "naila@example.com",
                      hintStyle: TextStyle(
                        color: AppTheme.textVariant.withOpacity(0.5),
                      ),
                      prefixIcon: const Icon(
                        LucideIcons.mail,
                        color: AppTheme.textVariant,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Password Field
                Text("PASSWORD", style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.textMain.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => TextField(
                      controller: authController.passwordController,
                      obscureText: authController.isPasswordHidden.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: "••••••••",
                        hintStyle: TextStyle(
                          color: AppTheme.textVariant.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          LucideIcons.lock,
                          color: AppTheme.textVariant,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authController.isPasswordHidden.value
                                ? LucideIcons.eyeOff
                                : LucideIcons.eye,
                            color: AppTheme.textVariant,
                          ),
                          onPressed: authController.togglePassword,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () => authController.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: AppTheme.primary.withOpacity(0.3),
                      ),
                      child: authController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login",
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Switch to Signup
                Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to the sanctuary? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed("/signup"),
                        child: Text(
                          "Create an account.",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppTheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
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
