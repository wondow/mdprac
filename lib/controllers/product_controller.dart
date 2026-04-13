import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final ApiService _api = ApiService();

  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;

  var bodyButters = <ProductModel>[].obs;
  var bodyScrubs = <ProductModel>[].obs;
  var bodyOils = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final response = await _api.get('products.php?action=get_all');

      if (response.data['success'] == true) {
        productList.clear();
        bodyButters.clear();
        bodyScrubs.clear();
        bodyOils.clear();

        List<dynamic> data = response.data['data'];
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          productList.add(product);

          if (product.categoryName == 'Butters') bodyButters.add(product);
          if (product.categoryName == 'Scrubs') bodyScrubs.add(product);
          if (product.categoryName == 'Oils') bodyOils.add(product);
        }
      }
    } catch (e) {
      print("Error fetching products: $e");
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      // If the search bar is empty, show all products again
      filteredProducts.assignAll(productList);
    } else {
      // Filter the master list where the product name contains the typed letters (ignoring uppercase/lowercase)
      filteredProducts.assignAll(
        productList
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
