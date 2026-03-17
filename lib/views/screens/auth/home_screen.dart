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
    "assets/images/body_scrub.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
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
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: AppWidget.semiboldTextFeildStyle()),
                  const Text(
                    "See all",
                    style: TextStyle(
                      color: Color(0xFF004a41),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(right: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: Color(0xFF935661),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(image: categories[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Products",
                    style: AppWidget.semiboldTextFeildStyle(),
                  ),
                  const Text(
                    "See all",
                    style: TextStyle(
                      color: Color(0xFF004a41),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              SizedBox(
                height: 300,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/shimmer_body_oil.png",
                            height: 190,

                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Shimmer Oil",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 1200",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/pineapple_mango.png",
                            height: 160,
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Pineapple mango Body butter",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 1255",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/blue_nila.png",
                            height: 190,

                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Blue nila Body Scrub",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 1200",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/bodybutter.png",
                            height: 190,

                            fit: BoxFit.cover,
                          ),
                          Text(
                            "French Vanilla Body Butter",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 2000",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/jasmine_vanilla.png",
                            height: 190,

                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Jasmine vanilla Body butter",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 1,900",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 20.0),

                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/mixed_order.png",
                            height: 190,

                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Combined Pack",
                            style: AppWidget.semiboldTextFeildStyle(),
                          ),
                          Row(
                            children: [
                              Text(
                                "ksh 4,000",
                                style: TextStyle(
                                  color: Color(0xFF004a41),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
