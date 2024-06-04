
import '../../models/consoles/active_order_model.dart';

class ConsoleActiveOrderResponse {
  late ConsoleActiveOrderModel activeOrder;

  ConsoleActiveOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 200) {
      activeOrder = ConsoleActiveOrderModel.fromJson(json);
    }
  }
} //end of response