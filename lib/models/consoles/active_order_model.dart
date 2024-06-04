class ConsoleActiveOrderModel {
  late String msg;

  late int status;

  ConsoleActiveOrderModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }
} //end of model
