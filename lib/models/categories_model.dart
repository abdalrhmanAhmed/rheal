class CategoriesModel {
  late int id;
  late String name;
  late String image;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ?? 'images/sh.png';
  }
} //end of model
