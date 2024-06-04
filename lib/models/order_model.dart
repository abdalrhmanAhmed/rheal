class OrderModel {
  late String consoleServiceId;
  late int userId;
  late String availableTimeId;
  late int status;
  OrderModel();
  OrderModel.fromJson(Map<String, dynamic> json) {
    consoleServiceId = json['console_service_id'];
    userId = json['user_id'];
    availableTimeId = json['available_time_id'];
    status = json['status'];
  }
}
