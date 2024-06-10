import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../controllers/settingController.dart';
import '../../models/setting_model.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.getsettings('about_app');
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
            iconSize: 29,
          ),
          title: Center(
            child: Text(
              "عن التطبيق",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF54D3C2), Color(0xFF54D3C2)],
              ),
            ),
          ),
        ),
        body: Obx(
          () {
            return settingController.isLoding.value == false
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF54D3C2),
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: Color(0xFF54D3C2),
                    color: Colors.white.withAlpha(59),
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          setState(() {
                            settingController.getsettings('about_app');
                          });
                        },
                      );
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(25, 30, 15, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        alignment: Alignment.center,
                        child: Html(
                          data: settingController.setting.value.value,
                          style: {
                            "body": Style(
                              fontSize: FontSize(20),
                              lineHeight: LineHeight(1.8),
                            ),
                          },
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
