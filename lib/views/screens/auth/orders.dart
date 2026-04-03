import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../configs/theme.dart';
import '../../../controllers/order_controller.dart';
import '../../../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller here so it fetches fresh data when opened
    final orderController = Get.put(OrderController());
    final currencyFormatter = NumberFormat.currency(
      symbol: 'Ksh ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Order History",
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primary),
          );
        }

        if (orderController.orderHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.packageOpen,
                  size: 80,
                  color: AppTheme.textVariant.withOpacity(0.2),
                ),
                const SizedBox(height: 20),
                Text(
                  "No past rituals found.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: orderController.orderHistory.length,
          itemBuilder: (context, index) {
            OrderModel order = orderController.orderHistory[index];
            String formattedDate = order.createdAt.split(' ')[0];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppTheme.surfaceContainer),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      LucideIcons.truck,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #DS-${order.id.toString().padLeft(4, '0')}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "$formattedDate • ${order.itemCount} Items",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormatter.format(order.totalAmount),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: order.status == 'pending'
                              ? AppTheme.surfaceContainerLowest
                              : AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order.status.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(fontSize: 9, color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
