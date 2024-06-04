import '../models/libarary_video_media_model.dart';

class LibararyVideoMediaResponse {
  List<LibararyVideoMediaModel> libarary_media_video = [];

  LibararyVideoMediaResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((cat) =>
        libarary_media_video.add(LibararyVideoMediaModel.fromJson(cat)));
  }
}
