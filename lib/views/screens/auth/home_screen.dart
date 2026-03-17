import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feb25prac/configs/colors.dart';
import 'package:feb25prac/views/widgets/support_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categories = [
    "assets/images/coco_vanilla.png",
    "assets/images/bod_oil.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey, Naila", style: AppWidget.boldTextFieldStyle()),
                    Text(
                      "Good Morning",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/ladybug.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products",
                  hintStyle: AppWidget.lightTextFeildStyle(),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiboldTextFeildStyle()),
                Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xFF004a41),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(left: 20.0),

              height: 120,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(image: categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFFB99099),
        backgroundColor: colorOnPrimary,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.line_style, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  const CategoryTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            width: 100,

            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white60, width: 1.5),
            ),
            child: Image.asset(image, height: 70, width: 70, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
