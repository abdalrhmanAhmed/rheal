import 'package:get/get.dart';
import 'package:rheal/models/notifaction_model.dart';
import 'package:rheal/responses/notifaction_response.dart';

import '../api_services/api.dart';

class CemeteryContactController extends GetxController {
  var isLoding = true.obs;
  var contact = <CemeteryContactModel>[].obs;

  Future<void> getNotifactions(int id) async {
    isLoding.value = true;
    var response = await Api.getcemeteryContacs(id);
    var categoryResponse = CemeteryContactResponse.fromJson(response.data);

    contact.clear();
    contact.addAll(categoryResponse.contact);
    isLoding.value = false;
  } //end of getGenres
} //end of controller

class CemeteryContactModel {
  late int id;
  late String type;
  late String value;

  CemeteryContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'] ?? '';
    value = json['value'] ?? '';
  }
}

class CemeteryContactResponse {
  List<CemeteryContactModel> contact = [];

  CemeteryContactResponse.fromJson(Map<String, dynamic> json) {
    json['data']
        .forEach((cat) => contact.add(CemeteryContactModel.fromJson(cat)));
  }
}
