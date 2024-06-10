import '../models/cemetery_details_model.dart';

class CemetryDetailResponse {
  late CemeteryDetailsModel cemetery_detail;

  CemetryDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] == false) {
      cemetery_detail = CemeteryDetailsModel.fromJson(json['data']);
    }
  }
}

class GraveResponse {
  late GraveModel graveModel;

  GraveResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] == false) {
      graveModel = GraveModel.fromJson(json['data']);
    }
  }
}
