class UserModel {
  late int id;
  late Map name;
  late String email;
  // late String? image;
  late String isActive;
  // late int type;
  late String phone;
  // late String country;
  // late int gendor;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    // image = json['photo'];
    isActive = json['status'];
    // type = json['type'];
    phone = json['phone'];
    // country = json['country'];
    // gendor = json['gendor'];
  }
} //end of model