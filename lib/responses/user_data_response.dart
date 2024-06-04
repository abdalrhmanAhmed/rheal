
import '../models/user_data_model.dart';

class UserDataResponse {
  late UserDataModel user;

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data']['error'] == false) {
      user = UserDataModel.fromJson(json['data']);
    }
  }
} //end of response