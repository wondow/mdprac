import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../configs/theme.dart';
import '../../../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser; // Safely grab user data

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Picture
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.surfaceContainer,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/ladybug.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name & Email
              Text(
                user?.name ?? "Sanctuary Member",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primary,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user?.email ?? "Loading...",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.snackbar(
                      'Coming Soon',
                      'Change password feature is under construction.',
                      backgroundColor: AppTheme.surfaceContainer,
                    ),
                    child: _buildActionButton(
                      context,
                      "Change Password",
                      AppTheme.surfaceContainerLowest,
                      AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => authController.logout(),
                    child: _buildActionButton(
                      context,
                      "Log Out",
                      Colors.red.withOpacity(0.1),
                      Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Personal Details Card
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.textMain.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Details",
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(fontSize: 20, color: AppTheme.primary),
                        ),
                        const Icon(
                          LucideIcons.user,
                          color: AppTheme.textVariant,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(context, "FULL NAME", user?.name ?? "N/A"),
                    _buildInfoRow(
                      context,
                      "PHONE NUMBER",
                      user?.phone ?? "N/A",
                    ),
                    _buildInfoRow(
                      context,
                      "DELIVERY ADDRESS",
                      user?.address ?? "N/A",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: AppTheme.textVariant.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: textColor, fontSize: 14),
      ),
    );
  }
}
