import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../configs/theme.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/product_model.dart';
import '../../widgets/cart_pill.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the CartController (It remembers the state from the HomeScreen!)
    final cartController = Get.find<CartController>();
    final currencyFormatter = NumberFormat.currency(
      symbol: 'Ksh ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          "Your Ritual Selection",
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontSize: 28),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Obx(() {
        // EMPTY STATE
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.shoppingBag,
                  size: 80,
                  color: AppTheme.textVariant.withOpacity(0.2),
                ),
                const SizedBox(height: 20),
                Text(
                  "Your sanctuary is empty.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  "Discover essentials on the home screen.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        // CART WITH ITEMS
        return Column(
          children: [
            // List of Cart Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  // Get the current item from the Map
                  final item = cartController.cartItems.values.elementAt(index);
                  final ProductModel product = item.product;

                  return _buildCartItemCard(
                    context,
                    product,
                    item.quantity,
                    currencyFormatter,
                  );
                },
              ),
            ),

            // Checkout Summary Area
            _buildCheckoutSummary(context, cartController, currencyFormatter),
          ],
        );
      }),
    );
  }

  // --- CART ITEM UI ---
  Widget _buildCartItemCard(
    BuildContext context,
    ProductModel product,
    int quantity,
    NumberFormat formatter,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.textMain.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              product.imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 80,
                width: 80,
                color: AppTheme.surfaceContainer,
                child: const Icon(
                  LucideIcons.imageOff,
                  color: AppTheme.textVariant,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  formatter.format(product.price),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Morphing Pill Controller
          const SizedBox(width: 10),
          MorphingCartPill(product: product),
        ],
      ),
    );
  }

  // --- CHECKOUT SUMMARY UI ---
  Widget _buildCheckoutSummary(
    BuildContext context,
    CartController cart,
    NumberFormat formatter,
  ) {
    double shipping = 350.0;
    double subtotal = cart.subtotal;
    double total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Subtotal Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: Theme.of(context).textTheme.bodyMedium),
              Text(
                formatter.format(subtotal),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Shipping Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping", style: Theme.of(context).textTheme.bodyMedium),
              Text(
                formatter.format(shipping),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(color: AppTheme.surfaceContainer, thickness: 1.5),
          ),

          // Total Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 24),
              ),
              Text(
                formatter.format(total),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                // We will hook this up to the XAMPP database in the next step!
                Get.snackbar(
                  "Processing",
                  "Contacting secure checkout...",
                  backgroundColor: AppTheme.surfaceContainer,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                shadowColor: AppTheme.primary.withOpacity(0.3),
              ),
              child: Text(
                "Complete Purchase",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "SECURE ENCRYPTED CHECKOUT SESSION",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              color: AppTheme.textVariant.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 60), // Space for the CurvedNavBar
        ],
      ),
    );
  }
}
