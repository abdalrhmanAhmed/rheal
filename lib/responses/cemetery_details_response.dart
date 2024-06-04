import '../models/cemetery_details_model.dart';

class CemetryDetailResponse {
  late CemeteryDetailsModel cemetery_detail;

  CemetryDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] == false) {
      cemetery_detail = CemeteryDetailsModel.fromJson(json['data']);
    }
  }
}
