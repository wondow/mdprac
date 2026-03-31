import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../configs/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      backgroundColor: AppTheme.background,
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
                      Text("Hey, Naila", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
                      Text("Good Morning", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/ladybug.png", height: 60, width: 60, fit: BoxFit.contain),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(color: AppTheme.textVariant.withOpacity(0.5)),
                    prefixIcon: const Icon(LucideIcons.search, color: AppTheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discover Essentials", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20)),
                  Text("See all", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary)),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                    height: 150,
                    margin: const EdgeInsets.only(right: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 80,
                        color: AppTheme.primary,
                        child: const Center(
                          child: Text("All", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150,
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
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Signature Selection", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20)),
                  Text("See all", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary)),
                ],
              ),
              const SizedBox(height: 20.0),
              
              // We will replace this static list with dynamic API data soon!
              SizedBox(
                height: 250,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard(context, "assets/images/shimmer_body_oil.png", "Shimmer Oil", "Ksh 1,200"),
                    _buildProductCard(context, "assets/images/pineapple_mango.png", "Pineapple Mango", "Ksh 1,255"),
                    _buildProductCard(context, "assets/images/blue_nila.png", "Blue Nila Scrub", "Ksh 1,200"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String imagePath, String title, String price) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppTheme.textMain.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(imagePath, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text(price, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary)),
              ],
            ),
          ),
        ],
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
      margin: const EdgeInsets.only(right: 15.0),
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
            child: Image.asset(image, fit: BoxFit.cover, width: double.infinity, height: 150),
          ),
        ),
      ),
    );
  }
}