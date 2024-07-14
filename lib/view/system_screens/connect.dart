import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

import '../../controllers/settingController.dart';

class connect extends StatefulWidget {
  connect({Key? key}) : super(key: key);

  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  final settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.getsettings('contact_us');
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
                "تواصل معنا",
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
              return settingController.isLoding.value == false
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
                          () {
                            setState(() {
                              settingController.getsettings('contact_us');
                            });
                          },
                        );
                      },
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 30, 15, 10),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Html(
                                    data: settingController.setting.value.value,
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(20.0),
                                        lineHeight: LineHeight(1.8),
                                      ),
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        ));
  }
}
