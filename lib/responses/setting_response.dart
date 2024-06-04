

import '../models/setting_model.dart';

class SettingResponse {
  late SettingModel setting ;

  SettingResponse.fromJson(Map<String, dynamic> json) {
        if (json['error'] == false) {
      setting = SettingModel.fromJson(json['data']);
    }
  }
}
