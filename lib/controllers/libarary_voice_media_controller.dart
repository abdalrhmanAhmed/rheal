import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/libarary_voice_media_model.dart';
import '../responses/libarary_voice_media_response.dart';

class LibararyVoiceMediaController extends GetxController {
  var isLoding = true.obs;
  var libarary_media_voice = <LibararyVoiceMediaModel>[].obs;

  Future<void> getLibararyVoiceMedia(int id, String type) async {
    isLoding.value = true;
    var response = await Api.getLibararyVoiceMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyVoiceMediaResponse.fromJson(response.data);

    libarary_media_voice.clear();
    libarary_media_voice.addAll(libarary_media_Response.libarary_media_voice);
    isLoding.value = false;
  } //end of getGenres
}
