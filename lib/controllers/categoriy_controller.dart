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

  Future<void> getNews() async {
    isLoding.value = true;
    var response = await Api.getNews();
    var categoryResponse = CategoryResponse.fromJson(response.data);

    cats.clear();
    cats.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getProject() async {
    isLoding.value = true;
    var response = await Api.getProject();
    var categoryResponse = CategoryResponse.fromJson(response.data);

    cats.clear();
    cats.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getabout() async {
    isLoding.value = true;
    var response = await Api.getabout();
    var categoryResponse = CategoryResponse.fromJson(response.data);

    cats.clear();
    cats.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getDeaths() async {
    isLoding.value = true;
    var response = await Api.getDeaths();
    var categoryResponse = CategoryResponse.fromJson(response.data);

    cats.clear();
    cats.addAll(categoryResponse.category);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
