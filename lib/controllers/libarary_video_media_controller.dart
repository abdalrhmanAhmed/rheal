import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/libarary_video_media_model.dart';
import '../responses/libarary_video_media_response.dart';

class LibararyVideoMediaController extends GetxController {
  var isLoding = true.obs;
  var libarary_media_video = <LibararyVideoMediaModel>[].obs;

  Future<void> getLibararyVideoMedia(int id, String type) async {
    isLoding.value = true;
    var response = await Api.getLibararyVideoMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyVideoMediaResponse.fromJson(response.data);

    libarary_media_video.clear();
    libarary_media_video.addAll(libarary_media_Response.libarary_media_video);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getNewsVideoMedia(int id, int type) async {
    isLoding.value = true;
    var response = await Api.getNewsVideoMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyVideoMediaResponse.fromJson(response.data);

    libarary_media_video.clear();
    libarary_media_video.addAll(libarary_media_Response.libarary_media_video);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getProjectVideoMedia(int id, int type) async {
    isLoding.value = true;
    var response = await Api.getProjectVideoMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyVideoMediaResponse.fromJson(response.data);

    libarary_media_video.clear();
    libarary_media_video.addAll(libarary_media_Response.libarary_media_video);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getAboutVideoMedia(int id, int type) async {
    isLoding.value = true;
    var response = await Api.getAboutVideoMedia(id: id, type: type);
    var libarary_media_Response =
        LibararyVideoMediaResponse.fromJson(response.data);

    libarary_media_video.clear();
    libarary_media_video.addAll(libarary_media_Response.libarary_media_video);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getCemetery(int id, int type) async {
    isLoding.value = true;
    var response = await Api.getCemetery(id: id, type: type);
    var libarary_media_Response =
        LibararyVideoMediaResponse.fromJson(response.data);

    libarary_media_video.clear();
    libarary_media_video.addAll(libarary_media_Response.libarary_media_video);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
