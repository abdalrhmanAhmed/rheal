
import '../../models/consoles/console_orders_model.dart';

class ConsoleOrdersResponse {
  List<ConsoleOrdersModel> consoleOrders = [];

  ConsoleOrdersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach(
          (order) => consoleOrders.add(ConsoleOrdersModel.fromJson(order)));
    }
  }
}
