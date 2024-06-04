class RegisterModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late int isActive;
  late int type;
  late String gendor;

  RegisterModel();

  RegisterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isActive = json['isActive'];
    type = json['type'];
    gendor = json['gendor'];
  }
} //end of model
