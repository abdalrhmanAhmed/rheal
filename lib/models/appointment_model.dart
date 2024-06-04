class AppointmentModel {
  late String name;
  late String service;
  late String? photo;
  late int status;
  late String day;
  late String from;
  late String to;
  late String text;
  late int orderId;

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    name = json['console']['name'];
    photo = json['console']['photo'];
    text = json['console']['text'];

    status = json['status'];
    service = json['service'];

    day = json['Time']['day'];
    from = json['Time']['from'];
    to = json['Time']['to'];
    orderId = json['order_id'];
  }
} //end of model

