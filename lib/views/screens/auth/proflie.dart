import 'package:flutter/material.dart';

import 'package:feb25prac/configs/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false,
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/ladybug.png"),
            ),
            SizedBox(height: 20),
            Text(
              "User Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildUserInfo("Name", "Micheals Amnhalie"),
            _buildUserInfo("Email", "amnhaliedanielmicheals@gmail.com"),
            _buildUserInfo("Phone", "+254 234006789"),
            _buildUserInfo("Address", "Daystar University, Athi River"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ignore: avoid_print
                print("Change Password initiated");
              },
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: colorOnPrimary,
      //   fixedColor: Color(0xFFB99099),
      //   currentIndex: 2,
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => const HomeScreen()),
      //         );
      //         break;
      //       case 1:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => const Orders()),
      //         );
      //         break;
      //       case 2:
      //         break;
      //     }
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Orders"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      //   ],
      // ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(value),
        SizedBox(height: 10),
      ],
    );
  }
}
