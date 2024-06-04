import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/libarary_media_model.dart';
import '../models/libarary_text_media_model.dart';
import '../responses/libarary_text_media_response.dart';

class LibararyTextMediaController extends GetxController {
  var isLoding = true.obs;
  var libarary_media_text = <LibararyTextMediaModel>[].obs;

  Future<void> getLibararyTextMedia(int id, String type) async {
    isLoding.value = true;
    var response = await Api.getLibararyTextMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyTextMediaResponse.fromJson(response.data);

    libarary_media_text.clear();
    libarary_media_text.addAll(libarary_media_Response.libarary_media_text);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
