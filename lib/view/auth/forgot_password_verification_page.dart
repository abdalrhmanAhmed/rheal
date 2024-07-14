// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, library_private_types_in_public_api, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/auth/client/clinet_login_screen.dart';

import '../../controllers/auth/otp_controller.dart';
import '../helpers/theme_helper.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key, required this.phone})
      : super(key: key);
  final String phone;

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
  String code = ''; // Initialize code as an empty string
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: AppColors.text,
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
                              Center(
                                child: Image.asset(
                                  "images/shura_logo.jpg",
                                  width: 350,
                                ),
                              ),
                              const SizedBox(height: 40.0),
                              Center(
                                child: Text(
                                  'تحقق',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  'أدخل رمز التحقق الذي أرسلناه لك للتو على رقم الهاتف الخاص بك',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
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
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+$')),
                                ],
                                keyboardType: TextInputType.number,
                                length: 6,
                                width: 300,
                                fieldWidth: 40,
                                style: TextStyle(fontSize: 20),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onChanged: (pin) {
                                  setState(() {
                                    code = pin;
                                  });
                                },
                                onCompleted: (pin) {
                                  setState(() {
                                    code = pin;
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
                                      text: '  إعادة المحاولة',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.off(ClientLoginScreen());
                                        },
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
                                        color: AppColors.text,
                                      ),
                                    ),
                                  ),
                                  onPressed: _pinSuccess
                                      ? () {
                                          // Add your verification logic here
                                          if (_formKey.currentState!
                                              .validate()) {
                                            otpController.sendOtp(
                                                phone: widget.phone,
                                                code: code);
                                          }
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
