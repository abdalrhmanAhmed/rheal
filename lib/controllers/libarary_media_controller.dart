import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/libarary_media_model.dart';
import '../responses/libarary_media_response.dart';

class LibararyMediaController extends GetxController {
  var isLoding = true.obs;
  var libarary_media = <LibararyMediaModel>[].obs;

  get libarary_media_video => null;

  Future<void> getLibararyMedia(int id, String type) async {
    isLoding.value = true;
    var response = await Api.getLibararyMedia(id: id, type: type);
    var libarary_media_Response = LibararyMediaResponse.fromJson(response.data);

    libarary_media.clear();
    libarary_media.addAll(libarary_media_Response.libarary_media);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
