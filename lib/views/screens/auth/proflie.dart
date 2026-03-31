import 'package:flutter/material.dart';
import '../../../configs/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: AppTheme.surfaceContainer,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/ladybug.png"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "User Profile",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            _buildUserInfo(context, "Name", "Micheals Amnhalie"),
            _buildUserInfo(
              context,
              "Email",
              "amnhaliedanielmicheals@gmail.com",
            ),
            _buildUserInfo(context, "Phone", "+254 234006789"),
            _buildUserInfo(
              context,
              "Address",
              "Daystar University, Athi River",
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 5),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 15),
      ],
    );
  }
}
