class UserDataModel {
  late int id;
  late String name;
  late String email;
  // late String? image;
  // late int isActive;
  // late int type;
  late String phone;
  // late String country;
  // late int gendor;

  UserDataModel();

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    // image = json['photo'];
    // isActive = json['isActive'];
    // type = json['type'];
    phone = json['phone'];
    // country = json['country'];
    // gendor = json['gendor'];
  }
} //end of model