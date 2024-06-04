class LibararyVoiceMediaModel {
  late int id;
  late String media;

  LibararyVoiceMediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
  }
} //end of model

