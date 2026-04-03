import 'dart:ui';

import 'package:feb25prac/services/api_service.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class CartItem {
  ProductModel product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  
  var cartItems = <int, CartItem>{}.obs;

 
  int getQuantity(int productId) {
    if (cartItems.containsKey(productId)) {
      return cartItems[productId]!.quantity;
    }
    return 0;
  }

  
  void addProduct(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      cartItems[product.id]!.quantity += 1;
    } else {
      cartItems[product.id] = CartItem(product: product);
    }
    cartItems.refresh(); 
  }

 
  void removeProduct(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      if (cartItems[product.id]!.quantity > 1) {
        cartItems[product.id]!.quantity -= 1;
      } else {
        cartItems.remove(product.id); 
      }
      cartItems.refresh();
    }
  }

  
  double get subtotal {
    double total = 0.0;
    cartItems.forEach((key, item) {
      total += (item.product.price * item.quantity);
    });
    return total;
  }

  
  Future<void> checkout(double totalAmount) async {
    if (cartItems.isEmpty) {
      Get.snackbar('Empty Cart', 'Please add items to your sanctuary first.');
      return;
    }

    try {
     
      List<Map<String, dynamic>> orderItems = cartItems.values.map((item) {
        return {
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price, 
        };
      }).toList();

      
      final response = await ApiService().post('checkout.php', {
        'total_amount': totalAmount,
        'items': orderItems,
      });

      
      if (response.data['success'] == true) {
        
        cartItems.clear();
        Get.snackbar(
          'Order Successful',
          response.data['message'],
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xFFFEEAE3), 
        );
      } else {
        Get.snackbar('Checkout Failed', response.data['message']);
      }
    } catch (e) {
      print("Checkout Error: $e");
      Get.snackbar('Error', 'Could not complete checkout. Please try again.');
    }
  }
  
}
