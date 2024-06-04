class ConsoleModel {
  late int primaryId;
  late int consoleId;
  late int serviceID;
  late String consoleName;
  late String? description;
  late String photo;
  late int gendor;
  late String country;
  late int type;
  late int isActive;
  late String? bio;
  late String? skills;
  late String? experiance;

  ConsoleModel.fromJson(Map<String, dynamic> json) {
    primaryId = json['id'];
    consoleId = json['console_id'];
    serviceID = json['service_id'];
    consoleName = json['user']['name'];
    photo = json["user"]["photo"] ?? "imaegs/sh.png";
    gendor = json["user"]["gendor"];
    country = json["user"]["country"];
    type = json["user"]["type"];
    isActive = json["user"]["isActive"];
    bio = json["console"]["bio"];
    skills = json["console"]["skills"];
    experiance = json["console"]["experiance"];
    description = json["console"]["description"];
  }
} //end of model

