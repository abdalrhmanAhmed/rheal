import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/categories_model.dart';
import '../responses/categoryies_response.dart';


class CategoryController extends GetxController {
  var isLoding = true.obs;
  var cats = <CategoriesModel>[].obs;

  Future<void> getcategory() async {
    isLoding.value = true;
    var response = await Api.getCategories();
    var categoryResponse = CategoryResponse.fromJson(response.data);

    cats.clear();
    cats.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres

} //end of controller
