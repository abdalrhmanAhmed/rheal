// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:rheal/controllers/warning_Controller.dart';
import 'package:rheal/responses/setting_response.dart';

import '../api_services/api.dart';
import '../models/setting_model.dart';

class SettingController extends GetxController with WarningController
{
  var setting = SettingModel().obs;
  var isLoding = false.obs;

  Future<void> getsettings(String key ) async {
    isLoding.value = false;
    var response = await Api.getSettings(key: key);
    if (response.statusCode == 200) {
      if (response.data['error'] == true) 
      {
         showAlert("خطأ في الإتصال",
            "انت تواجة مشكلة في الإتصال", "danger");
      }
      }
      if (response.data['error'] == false) 
      {
        var settingResponse = SettingResponse.fromJson(response.data);
        setting.value = settingResponse.setting;
        isLoding.value = true;
      }
    }

}