import '../models/libarary_media_model.dart';
import '../models/libarary_voice_media_model.dart';

class LibararyVoiceMediaResponse {
  List<LibararyVoiceMediaModel> libarary_media_voice = [];

  LibararyVoiceMediaResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((cat) =>
        libarary_media_voice.add(LibararyVoiceMediaModel.fromJson(cat)));
  }
}
