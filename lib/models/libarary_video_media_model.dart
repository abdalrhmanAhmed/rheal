class LibararyVideoMediaModel {
  late int id;
  late String media;

  LibararyVideoMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
  }
} //end of model
