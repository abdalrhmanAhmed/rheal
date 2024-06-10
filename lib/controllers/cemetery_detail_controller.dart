// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:rheal/controllers/warning_Controller.dart';

import '../api_services/api.dart';
import '../models/cemetery_details_model.dart';
import '../responses/cemetery_details_response.dart';

class CemeteryDetailController extends GetxController with WarningController {
  var cemetery_detail = CemeteryDetailsModel().obs;
  var isLoding = false.obs;

  Future<void> getCemeteryDetail(int id) async {
    isLoding.value = false;
    var response = await Api.getCemeteryDetail(id: id);
    print(response);
    if (response.statusCode == 200) {
      if (response.data['error'] == true) {
        showAlert("خطأ في الإتصال", "انت تواجة مشكلة في الإتصال", "danger");
      }
    }
    if (response.data['error'] == false) {
      var cemetry_detail_response =
          CemetryDetailResponse.fromJson(response.data);
      print('#####################################');
      print(cemetry_detail_response.cemetery_detail);
      print('#####################################');
      cemetery_detail.value = cemetry_detail_response.cemetery_detail;
      isLoding.value = true;
    }
  }
}

class GraveController extends GetxController with WarningController {
  var graveModel = GraveModel().obs;
  var isLoding = false.obs;

  Future<void> getGrave(int id) async {
    isLoding.value = false;
    var response = await Api.getGrave(id: id);
    print(response);
    if (response.statusCode == 200) {
      if (response.data['error'] == true) {
        showAlert("خطأ في الإتصال", "انت تواجة مشكلة في الإتصال", "danger");
      }
    }
    if (response.data['error'] == false) {
      var cemetry_detail_response = GraveResponse.fromJson(response.data);
      print('#####################################');
      print(cemetry_detail_response.graveModel);
      print('#####################################');
      graveModel.value = GraveModel(); // Clear existing data
      graveModel.value = cemetry_detail_response.graveModel;
      isLoding.value = true;
    }
  }
}
