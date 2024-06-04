
import '../../../models/auth/client/user_model.dart';

class UserResponse {
  late UserModel user;
  late String? token;

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 200) {
      user = UserModel.fromJson(json['data']['user']);
      token = json['data']['token'];
    }
  }
} //end of response
