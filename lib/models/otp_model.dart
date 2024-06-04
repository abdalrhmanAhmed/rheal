class OtpModel {
  late int id;
  late String name;
  late String email;
  late String image;
  late int isActive;

  OtpModel();

  OtpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['photo'] ?? "images/sh.png";
    isActive = json['isActive'];
  }
} //end of model