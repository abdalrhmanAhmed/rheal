import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/finalLibarary/Deaths/FullScreenImage.dart';

import '../../../controllers/categoriy_controller.dart';
import '../../../models/categories_model.dart';

class DeathsScreen extends StatefulWidget {
  DeathsScreen({Key? key}) : super(key: key);

  @override
  State<DeathsScreen> createState() => _Home_PageState();
}

class _Home_PageState extends State<DeathsScreen> {
  final categorieController = Get.put(CategoryController());

  @override
  void initState() {
    categorieController.getDeaths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 29,
            ),
          ),
          title: Center(
            child: Text(
              "حالات الوفاة اليومية",
              style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: AppColors.text),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  AppColors.background,
                  AppColors.background,
                ])),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(top: 5, right: 50, left: 3, bottom: 10),
              child: Stack(
                children: <Widget>[],
              ),
            )
          ],
        ),
        body: Obx(
          () {
            return categorieController.isLoding.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.background,
                    color: AppColors.text,
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () async {
                          await categorieController.getNews();
                        },
                      );
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: categorieController.cats.length,
                      itemBuilder: (context, index) {
                        return buildServices(categorieController.cats[index]);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget buildServices(CategoriesModel cats) {
  return InkWell(
    onTap: () {
      Get.to(() => FullScreenImage(
          imageUrl:
              "https://cemetery2.bmwit.com/public/Library-profile/${cats.image}"));
    },
    child: Hero(
      tag: "image_${cats.id}",
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                AppColors.background,
                AppColors.text,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://cemetery2.bmwit.com/public/Library-profile/${cats.image}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      "${cats.name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
