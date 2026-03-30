import 'package:feb25prac/configs/colors.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(" Orders"),
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false,
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Ordered Products",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildFavoriteProducts(),
          ],
        ),
      ),
      
    );
  }

  Widget _buildFavoriteProducts() {
    final List<Map<String, dynamic>> favoriteProducts = [
      {
        "name": "Jasmine vanilla Body butter",
        "price": "ksh 2,500",
        "image": "assets/images/jasmine_vanilla.png",
      },
      {
        "name": "French vanilla Body butter",
        "price": "ksh 1,900",
        "image": "assets/images/bodybutter.png",
      },
      {
        "name": "Combined Pack",
        "price": "ksh 4,000",
        "image": "assets/images/mixed_order.png",
      },
    ];
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // ignore: avoid_print
              print("Product tapped: ${favoriteProducts[index]['name']}");
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      favoriteProducts[index]["image"],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        favoriteProducts[index]["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(favoriteProducts[index]["price"]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
