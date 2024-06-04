import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class message extends StatefulWidget {
  message({Key? key}) : super(key: key);

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  @override
  void initState() {
    // Timer(Duration(seconds: 1), () {
    //   warningController().underDev('home');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(child: Text('لا توجد بيانات')),
      ),
    );
  }
}
