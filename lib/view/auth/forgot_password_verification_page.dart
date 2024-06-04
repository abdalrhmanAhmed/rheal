// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, library_private_types_in_public_api, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../controllers/auth/otp_controller.dart';
import '../../controllers/warning_Controller.dart';
import '../helpers/theme_helper.dart';

// import 'package:shura/view/screens/auth/chang_password_screen.dart';

// import 'widgets/header_widget.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key, required this.phone})
      : super(key: key);
  final phone;

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final otpController = Get.put(OtpController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _phoneData = {};
  bool _pinSuccess = false;
  var code;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'تحقق',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                                textAlign: TextAlign.center,

                                // textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'أدخل رمز التحقق الذي أرسلناه لك للتو على رقم الهاتف الخاص بك',
                                style: TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                                // textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              OTPTextField(
                                length: 4,
                                width: 300,
                                fieldWidth: 50,
                                style: TextStyle(fontSize: 30),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onChanged: (pin) {
                                  code += pin;
                                },
                                onCompleted: (pin) {
                                  setState(() {
                                    print(pin);
                                    _pinSuccess = true;
                                  });
                                },
                              ),
                              SizedBox(height: 50.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: " إذا لم تتلق رمز ! ",
                                      style: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '  إعادة إرسال',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                decoration: _pinSuccess
                                    ? ThemeHelper().buttonBoxDecoration(context)
                                    : ThemeHelper().buttonBoxDecoration(
                                        context, "#AAAAAA", "#757575"),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "تاكيد".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: _pinSuccess
                                      ? () {
                                          WarningController().underDev('home');
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
