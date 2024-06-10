import 'dart:async';

// import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/main_controller.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../controllers/warning_Controller.dart';

import 'package:get/get.dart';

import 'images.dart';
import 'text.dart';
import 'vedio.dart';
import 'voice.dart';

class MediaHomeScreen3 extends StatefulWidget {
  late String name;
  late int id;
  MediaHomeScreen3({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);
  @override
  State<MediaHomeScreen3> createState() => _MyPluginState();
}

class _MyPluginState extends State<MediaHomeScreen3> {
  final mainController = Get.find<MainController>();
  final warningcontroller = Get.put(WarningController());
  final gardcontroller = Get.put(UserDataContoller());

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DefaultTabController(
        length: 4,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            appBar: AppBar(
              backgroundColor: Color(0xFF54D3C2),
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
                  widget.name,
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
                  margin:
                      EdgeInsets.only(top: 5, right: 50, left: 3, bottom: 10),
                  child: Stack(
                    children: <Widget>[],
                  ),
                )
              ],
              bottom: TabBar(indicatorColor: Colors.white, tabs: [
                Tab(
                  child: Text(
                    "صور",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    Icons.image,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    "فيديو",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.video_camera_back,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    "صوتيات",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.mic,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    "نصوص",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.document_scanner,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            body: TabBarView(children: [
              NewsImageScreen(
                id: widget.id,
              ),
              NewsVideoScreen(
                id: widget.id,
              ),
              NewsVoiceScreen(
                id: widget.id,
              ),
              ProjectTextScreen(
                id: widget.id,
              ),
            ]),
          ),
        ));
  }
}
