
import '../models/categories_model.dart';

class CategoryResponse {
  List<CategoriesModel> category = [];

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((cat) => category.add(CategoriesModel.fromJson(cat)));
  }
}
