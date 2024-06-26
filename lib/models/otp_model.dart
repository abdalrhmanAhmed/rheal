class OtpModel {
  late String data;

  OtpModel();

  OtpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }
} //end of model