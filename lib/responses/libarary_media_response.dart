import '../models/libarary_media_model.dart';

class LibararyMediaResponse {
  List<LibararyMediaModel> libarary_media = [];

  LibararyMediaResponse.fromJson(Map<String, dynamic> json) {
    json['data']
        .forEach((cat) => libarary_media.add(LibararyMediaModel.fromJson(cat)));
  }
}
