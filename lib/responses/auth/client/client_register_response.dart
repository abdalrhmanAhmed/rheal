
import '../../../models/auth/client/register_model.dart';

class ClinetRegisterResponse {
  late RegisterModel register;

  ClinetRegisterResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 201) {
      register = RegisterModel.fromJson(json['data']);
    }
  }
} //end of response
