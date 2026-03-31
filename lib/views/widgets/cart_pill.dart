import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../controllers/cart_controller.dart';
import '../../models/product_model.dart';
import '../../configs/theme.dart';

class MorphingCartPill extends StatelessWidget {
  final ProductModel product;
  const MorphingCartPill({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Obx(() {
      int quantity = cartController.getQuantity(product.id);
      bool inCart = quantity > 0;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: 35,
        width: inCart ? 100 : 35,
        decoration: BoxDecoration(
          color: inCart ? AppTheme.primary : AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(30),
          border: inCart
              ? null
              : Border.all(
                  color: AppTheme.primary.withOpacity(0.5),
                  width: 1.5,
                ),
        ),
        // THE FIX: SingleChildScrollView prevents the Row from crashing the app during the 300ms animation
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: inCart ? 100 : 35,
            child: inCart
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => cartController.removeProduct(product),
                        child: const Icon(
                          LucideIcons.minus,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => cartController.addProduct(product),
                        child: const Icon(
                          LucideIcons.plus,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () => cartController.addProduct(product),
                    child: const Center(
                      child: Icon(
                        LucideIcons.plus,
                        size: 18,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
