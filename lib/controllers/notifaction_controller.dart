import 'package:get/get.dart';
import 'package:rheal/models/notifaction_model.dart';
import 'package:rheal/responses/notifaction_response.dart';

import '../api_services/api.dart';

class NotifactionController extends GetxController {
  var isLoding = true.obs;
  var notice = <NotifactionModel>[].obs;

  Future<void> getNotifactions() async {
    isLoding.value = true;
    var response = await Api.getNotifcation();
    var categoryResponse = NotifactionResponse.fromJson(response.data);

    notice.clear();
    notice.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
