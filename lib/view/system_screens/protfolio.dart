import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/settingController.dart';

class protfolio extends StatefulWidget {
  protfolio({Key? key}) : super(key: key);

  @override
  State<protfolio> createState() => _protfolioState();
}

class _protfolioState extends State<protfolio> {
  final settingController = Get.put(SettingController());

  @override
  void initState() {
    settingController.getsettings('google_key');
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
                "الدعم الفني",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
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
                  ])),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(top: 5, right: 50, left: 3, bottom: 10),
                child: Stack(
                  children: <Widget>[
                  
                  ],
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
                              settingController.getsettings('google_key');
                            });
                          },
                        );
                      },
                      child: SingleChildScrollView(
                          child: Stack(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(25, 30, 15, 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // start avatar icon
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        color: Colors.white,
                                        boxShadow: [
                             
                                        ],
                                      ),
                                      child:
                                      Padding(
                                        padding: EdgeInsets.only(left: 0, right: 0),
                                        child: Text(
                                        // parse(settingController.setting.value.value).outerHtml,
                                        settingController.setting.value.value,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 20,height: 1.8),
                                      ),
                                    ),),
                 
                                  ],
                                ),
                              ),
                              // end avatar icon
                              SizedBox(height: 10),
                              // start name filed
                        
                              // end name filed
                              SizedBox(height: 10),
                              // start user info
                      
                              // end user info
                              SizedBox(height: 20),
                              // start email and password filed
                              GestureDetector(
                                child: Column(
                                  children: [
                          
                                    SizedBox(
                                      height: 15,
                                    ),
                              
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              // end email and password filed
                              SizedBox(height: 20),
                              // start send button
                              // end send button
                            ],
                          ),
                        )
                      ])),
                    );
            },
          ),
        ));
  }
}