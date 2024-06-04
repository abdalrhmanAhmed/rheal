class LibararyTextMediaModel {
  late int id;
  late String media;

  LibararyTextMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
  }
} //end of model
