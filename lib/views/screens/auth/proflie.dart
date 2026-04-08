import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../configs/theme.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/profile_controller.dart'; // Import the new controller

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileController = Get.put(ProfileController()); // Inject it here

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() {
            // Obx wrapper so the UI updates instantly when checkLoginStatus finishes!
            final user = authController.currentUser.value;

            return Column(
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
                      onTap: () =>
                          _showChangePasswordSheet(context, profileController),
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
                                ?.copyWith(
                                  fontSize: 20,
                                  color: AppTheme.primary,
                                ),
                          ),
                          IconButton(
                            icon: const Icon(
                              LucideIcons.edit2,
                              color: AppTheme.primary,
                              size: 20,
                            ),
                            onPressed: () {
                              profileController.prefillData();
                              _showEditProfileSheet(context, profileController);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                const SizedBox(height: 100),
              ],
            );
          }),
        ),
      ),
    );
  }

  // --- BOTTOM SHEETS ---

  void _showEditProfileSheet(
    BuildContext context,
    ProfileController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                context,
                "Full Name",
                controller.nameController,
                LucideIcons.user,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                context,
                "Phone Number",
                controller.phoneController,
                LucideIcons.phone,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                context,
                "Street Address",
                controller.addressController,
                LucideIcons.mapPin,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.updateProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Save Changes",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows sheet to move up when keyboard appears
    );
  }

  void _showChangePasswordSheet(
    BuildContext context,
    ProfileController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Password",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Obx(
                () => _buildTextField(
                  context,
                  "Current Password",
                  controller.currentPasswordController,
                  LucideIcons.lock,
                  isPassword: true,
                  hidden: controller.isPasswordHidden.value,
                  toggle: controller.togglePassword,
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => _buildTextField(
                  context,
                  "New Password",
                  controller.newPasswordController,
                  LucideIcons.key,
                  isPassword: true,
                  hidden: controller.isPasswordHidden.value,
                  toggle: controller.togglePassword,
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                () => _buildTextField(
                  context,
                  "Confirm New Password",
                  controller.confirmPasswordController,
                  LucideIcons.checkCircle,
                  isPassword: true,
                  hidden: controller.isPasswordHidden.value,
                  toggle: controller.togglePassword,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.changePassword(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Update Password",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildTextField(
    BuildContext context,
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    bool hidden = false,
    VoidCallback? toggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.surfaceContainerLowest),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? hidden : false,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.textVariant.withOpacity(0.5)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    hidden ? LucideIcons.eyeOff : LucideIcons.eye,
                    color: AppTheme.textVariant,
                  ),
                  onPressed: toggle,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
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
