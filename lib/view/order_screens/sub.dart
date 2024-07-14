// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

import '../../controllers/service_controller.dart';
import '../../models/services_model.dart';
import 'console_screen.dart';

class sub extends StatefulWidget {
  sub({Key? key, required this.id, required this.tital, required this.image})
      : super(key: key);
  final int id;
  final String tital;
  final String image;

  @override
  State<sub> createState() => _subState();
}

class _subState extends State<sub> {
  final serviceController = Get.put(ServiceController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    serviceController.getservices(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 35,
          ),
          title: Center(
            child: Text(
              "${widget.tital}",
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
              margin: EdgeInsets.only(top: 5, right: 55, left: 3, bottom: 10),
            )
          ],
        ),
        // end appBar

        // start body
        body: Obx(
          () {
            return serviceController.isLoding.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    // backgroundColor: AppColors.background,
                    color: AppColors.text.withAlpha(59),
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          /// adding elements in list after [1 seconds] delay
                          /// to mimic network call
                          ///
                          /// Remember: setState is necessary so that
                          /// build method will run again otherwise
                          /// list will not show all elements
                          setState(() {
                            serviceController.getservices(widget.id);
                          });

                          // showing snackbar
                          // _scaffoldKey.currentState!.showSnackBar(
                          //   SnackBar(
                          //     content: const Text('تم تحديث البيانات بنجاح'),
                          //   ),
                          // );
                        },
                      );
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return buildServices(widget.image);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget buildServices(image) {
  return Column(children: [
    SizedBox(
      height: 10,
    ),
    InkWell(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(8),
          // width: MediaQuery.of(context).size.width * 0.45,
          height: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.text.withAlpha(50),
                AppColors.text.withAlpha(59),
              ], begin: Alignment.bottomCenter, end: Alignment.centerRight),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5, 8),
                  blurRadius: 10,
                  color: AppColors.background.withAlpha(25),
                )
              ]),
          child: Column(
            children: [
              Container(
                height: 100,
                margin: EdgeInsets.only(top: 10),
                child: InkWell(
                  child: Image.network(
                    "https://cemetery2.bmwit.com/public/libary-profile/${image}",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    height: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                child: Center(
                  child: Center(
                    child: Text(
                      "test",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        // warningController().underDev('home');
        // Get.to(() => ConsolesScreen(
        //       id: services.id,
        //       tital: '${services.name}',
        //     ));
      },
    )
  ]);
}
