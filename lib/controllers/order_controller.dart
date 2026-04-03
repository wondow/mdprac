import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  final ApiService _api = ApiService();

  var isLoading = true.obs;
  var orderHistory = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    isLoading.value = true;
    try {
      final response = await _api.get('orders.php');

      if (response.data['success'] == true) {
        orderHistory.clear();
        List<dynamic> data = response.data['data'];
        for (var item in data) {
          orderHistory.add(OrderModel.fromJson(item));
        }
      }
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
