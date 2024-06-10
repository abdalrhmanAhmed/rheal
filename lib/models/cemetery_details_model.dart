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
    lat = double.parse((json['lat'])); // Check for num type first
    long = double.parse(json['long']);
  }
} //end of model

class GraveModel {
  late int id;
  late String? name;
  late String? cemetery_name;
  late double northing;
  late double easting;
  late double elevation;

  GraveModel();

  GraveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] ?? '';
    cemetery_name = json['cemetery_name'] ?? '';

    // Print the values of json['x'] and json['y'] for debugging
    print('Longitude value (json["northing"]): ${json['northing']}');
    print('Longitude value (json["easting"]): ${json['easting']}');
    print('Longitude value (json["elevation"]): ${json['elevation']}');

    // Attempt to parse latitude and longitude as doubles
    try {
      northing = double.parse(json['northing'].toString());
      easting = double.parse(json['easting'].toString());
      elevation = double.parse(json['elevation'].toString());
    } catch (e) {
      print('Error parsing latitude or longitude: $e');
      // Handle the error accordingly (e.g., set default values)

      northing = 0.0;
      easting = 0.0;
      elevation = 0.0;
    }
  }
}
