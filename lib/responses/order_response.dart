
import '../models/order_model.dart';

class OrderResponse {
  late OrderModel orders;

  OrderResponse.fromJson(Map<String, dynamic> json) {
    orders = OrderModel.fromJson(json['data']);
  }
}
