class SettingModel {
  // late int id;
  late String key;
  late String value;

  SettingModel();

  SettingModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'] ?? '';
    key  = json['key'] ?? '';
    value = json['value'] ?? '';
  }
} //end of model
