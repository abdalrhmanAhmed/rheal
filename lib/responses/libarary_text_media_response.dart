import '../models/libarary_text_media_model.dart';

class LibararyTextMediaResponse {
  List<LibararyTextMediaModel> libarary_media_text = [];

  LibararyTextMediaResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach(
        (cat) => libarary_media_text.add(LibararyTextMediaModel.fromJson(cat)));
  }
}
