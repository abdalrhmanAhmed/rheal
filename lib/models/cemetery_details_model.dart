class CemeteryDetailsModel {
  late int id;
  late String name;
  late String text;
  late double lat;
  late double long;

  CemeteryDetailsModel();

  CemeteryDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] ?? '';
    text = json['text'] ?? '';
    lat = (json['lat'] as num?)?.toDouble() ?? 0.0; // Check for num type first
    long = (json['long'] as num?)?.toDouble() ?? 0.0;
  }
} //end of model
