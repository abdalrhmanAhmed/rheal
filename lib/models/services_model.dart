class ServicesModel {
  late int id;
  late String text;
  late String image;
  late String video;
  late String voice;

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    text  = json['text'] ?? '';
    image = json['iamge'] ?? '';
    video = json['video'] ?? '';
    voice = json['voice'] ?? '';
  }
} //end of model
