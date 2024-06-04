// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:get/get.dart';

import '../../controllers/warning_Controller.dart';
import 'client/clinet_login_screen.dart';

// import 'package:shura/view/screens/auth/console/console_login_screen.dart';

class We extends StatelessWidget {
  const We({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: Container()),
              Expanded(child: Container()),
              Container(
                  margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  width: double.infinity,
                  height: 500,
                  //  MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF54D3C2), Color(0xFF54D3C2)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.centerRight),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 8),
                          blurRadius: 10,
                          color: const Color(0xFF54D3C2).withAlpha(25),
                        )
                      ]),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: AnimatedButton(
                          child: const Text(
                            'لغة عربية',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF54D3C2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Get.to(() => const ClientLoginScreen());
                          },
                          enabled: true,
                          shadowDegree: ShadowDegree.light,
                        ),
                      ),
                      
                      Expanded(child: Container()),
                    ],
                  )),
              Expanded(child: Container()),
            ],
          ),
        ));
  }
}
