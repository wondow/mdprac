import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../configs/theme.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/order_controller.dart';
import '../../../models/order_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controllers
    final authController = Get.find<AuthController>();
    final orderController = Get.put(OrderController());
    final currencyFormatter = NumberFormat.currency(
      symbol: 'Ksh ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Header
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.surfaceContainer,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/ladybug.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Dynamic User Info
              Text(
                authController.currentUser?.name ?? "Sanctuary Member",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primary,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                authController.currentUser?.email ?? "email@example.com",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Change Password Button
                  GestureDetector(
                    onTap: () {
                      // We haven't built this screen yet, so just show a snackbar!
                      Get.snackbar(
                        'Coming Soon',
                        'Change password feature is under construction.',
                        backgroundColor: AppTheme.surfaceContainer,
                      );
                    },
                    child: _buildActionButton(
                      context,
                      "Change Password",
                      AppTheme.surfaceContainer,
                      AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Log Out Button
                  GestureDetector(
                    onTap: () {
                      // Call the new secure logout method!
                      authController.logout();
                    },
                    child: _buildActionButton(
                      context,
                      "Log Out",
                      Colors.red.withOpacity(0.1),
                      Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Order History Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order History",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 24,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Dynamic Order List
              Obx(() {
                if (orderController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  );
                }

                if (orderController.orderHistory.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "No past orders found.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderController.orderHistory.length,
                  itemBuilder: (context, index) {
                    OrderModel order = orderController.orderHistory[index];

                    // Format the date (e.g., "2024-03-30 14:00:00" -> "2024-03-30")
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
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                currencyFormatter.format(order.totalAmount),
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: AppTheme.primary),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: order.status == 'pending'
                                      ? AppTheme.surfaceContainer
                                      : AppTheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  order.status.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        fontSize: 9,
                                        color: AppTheme.primary,
                                      ),
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
              const SizedBox(height: 100), // Space for NavBar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: textColor, fontSize: 14),
      ),
    );
  }
}
