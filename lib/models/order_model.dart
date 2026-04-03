class OrderModel {
  final int id;
  final double totalAmount;
  final String status;
  final String createdAt;
  final int itemCount;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.itemCount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      totalAmount: double.parse(json['total_amount'].toString()),
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] ?? '',
      itemCount: json['item_count'] != null
          ? int.parse(json['item_count'].toString())
          : 0,
    );
  }
}
