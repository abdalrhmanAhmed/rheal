import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../controllers/settingController.dart';

class Conditions extends StatefulWidget {
  Conditions({Key? key}) : super(key: key);

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  final settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.getsettings('terms_and_conditions');
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
              "الشروط و الأحكام",
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
                colors: [
                  Color(0xFF54D3C2),
                  Color(0xFF54D3C2),
                ],
              ),
            ),
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
                            settingController
                                .getsettings('terms_and_conditions');
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
      ),
    );
  }
}
