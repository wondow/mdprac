import 'package:flutter/material.dart';
import '../../../configs/theme.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text("Orders", style: Theme.of(context).textTheme.displayMedium),
        backgroundColor: AppTheme.surfaceContainer,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Ordered Products",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 20),
            _buildFavoriteProducts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteProducts(BuildContext context) {
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
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: Image.asset(
                      favoriteProducts[index]["image"],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      favoriteProducts[index]["name"],
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      favoriteProducts[index]["price"],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
