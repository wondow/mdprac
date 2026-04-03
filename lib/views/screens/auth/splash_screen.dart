import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/theme.dart';
import '../../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // As soon as the splash screen loads, ask the AuthController to check the token
    Get.find<AuthController>().checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Beautiful Ladybug Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage("assets/images/ladybug.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Sanctuary Branding
            Text(
              "Digital Sanctuary",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 32,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Wrap your skin in more",
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(letterSpacing: 2.0),
            ),

            const SizedBox(height: 50),
            // Elegant loading indicator
            const CircularProgressIndicator(
              color: AppTheme.primary,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
