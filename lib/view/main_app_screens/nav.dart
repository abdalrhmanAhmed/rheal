import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

// import 'home.dart';
import 'package:get/get.dart';

import '../system_screens/conditions.dart';
import '../system_screens/connect.dart';
import '../system_screens/protfolio.dart';
import 'Home.dart';

class Nav extends StatefulWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _navState();
}

class _navState extends State<Nav> {
  get fabKey => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MyPlugin(),
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomRight,
          ringColor: Color(0xFF54D3C2).withAlpha(25),
          ringDiameter: 400.0,
          ringWidth: 100.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          fabColor: Colors.white,
          fabOpenIcon: Icon(
            Icons.menu_outlined,
            color: Color(0xFF54D3C2),
            size: 30,
          ),
          fabCloseIcon: Icon(Icons.close, color: Color(0xFF54D3C2)),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {},
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 155),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(Conditions());
                    },
                    icon: Icon(Icons.announcement_sharp),
                    color: Color(0xFF54D3C2),
                  ),
                  Text(
                    "الشروط و الاحكام",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 155),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(connect());
                    },
                    icon: Icon(Icons.contact_phone_outlined),
                    color: Color(0xFF54D3C2),
                  ),
                  Text(
                    "تواصل معنا",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 155),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(protfolio());
                    },
                    icon: Icon(Icons.support),
                    color: Color(0xFF54D3C2),
                  ),
                  Text(
                    "الدعم الفني",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
