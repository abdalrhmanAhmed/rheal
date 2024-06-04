class ClientApointmentModel {
  late int id;
  late String name;
  late String? image;
  late String? text;
  late double? lat;
  late double? long;

  ClientApointmentModel.fromJson(Map<String, dynamic> json) {
    // Parse northing and easting only if they are numeric strings
    double lat = json['lat'] is String && double.tryParse(json['lat']) != null
        ? double.parse(json['lat'])
        : 0.0; // Default value if parsing fails

    double long =
        json['long'] is String && double.tryParse(json['long']) != null
            ? double.parse(json['long'])
            : 0.0; // Default value if parsing fails

    id = json['id'];
    name = json['name'];
    image = json['image'];
    text = json['text'];
    lat = lat;
    long = long;
  }
} //end of model
