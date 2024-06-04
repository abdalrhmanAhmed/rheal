class ConsoleOrdersModel {
  late String name;
  late String service;
  late String? photo;
  late int status;
  late String day;
  late String from;
  late String to;
  late int orderId;

  ConsoleOrdersModel.fromJson(Map<String, dynamic> json) {
    name = json['client']['name'];
    photo = json['client']['photo'];

    status = json['status'];
    service = json['service'];

    day = json['Time']['day'];
    from = json['Time']['from'];
    to = json['Time']['to'];
    orderId = json['order_id'];
  }
} //end of model
