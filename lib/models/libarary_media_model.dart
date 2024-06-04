class LibararyMediaModel {
  late int id;
  late String media;

  LibararyMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
  }
} //end of model

