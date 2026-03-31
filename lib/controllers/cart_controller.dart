import 'package:get/get.dart';
import '../models/product_model.dart';

class CartItem {
  ProductModel product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  // A map where the Key is the Product ID, and the Value is the CartItem
  var cartItems = <int, CartItem>{}.obs;

  // Get current quantity of a specific product
  int getQuantity(int productId) {
    if (cartItems.containsKey(productId)) {
      return cartItems[productId]!.quantity;
    }
    return 0;
  }

  // Add one to cart
  void addProduct(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      cartItems[product.id]!.quantity += 1;
    } else {
      cartItems[product.id] = CartItem(product: product);
    }
    cartItems.refresh(); // Tells GetX to redraw the UI
  }

  // Remove one from cart
  void removeProduct(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      if (cartItems[product.id]!.quantity > 1) {
        cartItems[product.id]!.quantity -= 1;
      } else {
        cartItems.remove(product.id); // If it hits 0, delete it
      }
      cartItems.refresh();
    }
  }

  // Calculate Subtotal (We will use this on the Checkout screen later)
  double get subtotal {
    double total = 0.0;
    cartItems.forEach((key, item) {
      total += (item.product.price * item.quantity);
    });
    return total;
  }
}
