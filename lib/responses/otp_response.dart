
import '../models/otp_model.dart';

class OtpResponse {
  late OtpModel otps;

  OtpResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 201) {
      otps = OtpModel.fromJson(json['data']);
    }
  }
} //end of response
