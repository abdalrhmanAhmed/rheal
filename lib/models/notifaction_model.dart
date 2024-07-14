class NotifactionModel {
  late int id;
  late String title;
  late String image;
  late String description;

  NotifactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'] ?? 'images/sh.png';
    description = json['description'] ?? '';
  }
} //end of model
