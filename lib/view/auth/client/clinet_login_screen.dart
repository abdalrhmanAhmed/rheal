import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rheal/controllers/auth/otp_controller.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/theme_helper.dart';

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ClientLoginScreen> {
  final clientAuthController = Get.put(OtpController());

  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {};

  void _launchPhone() async {
    const phoneNumber = 'tel:092239158'; // Replace with your phone number
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _launchInstagram() async {
    const igUrl =
        'https://www.instagram.com/janazafujairah?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw=='; // Replace with your Instagram page URL
    // ignore: deprecated_member_use
    if (await canLaunch(igUrl)) {
      // ignore: deprecated_member_use
      await launch(igUrl);
    } else {
      throw 'Could not launch $igUrl';
    }
  }

  void _launchWebsite() async {
    const websiteUrl =
        'https://graveyards-fuj.ae/'; // Replace with your website URL
    if (await canLaunch(websiteUrl)) {
      await launch(websiteUrl);
    } else {
      throw 'Could not launch $websiteUrl';
    }
  }

  void _launchCompanyWebsite() async {
    const companyUrl = 'https://www.baps.ae/'; // Replace with your company URL
    if (await canLaunch(companyUrl)) {
      await launch(companyUrl);
    } else {
      throw 'Could not launch $companyUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.text,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Center(),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          "images/shura_logo.jpg",
                          width: 350,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يجب إدخال رقم الهاتف';
                                  }
                                  if (value.length < 9 || value.length > 10) {
                                    return 'رقم الهاتف يجب أن يكون بين 9 و 10 أرقام';
                                  }
                                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                                    return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                decoration: ThemeHelper().textInputDecoration(
                                  'رقم الهاتف',
                                  'ادخل رقم الهاتف',
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'دخول'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginData['phone'] = _phoneController.text;
                                    _loginData['password'] = 'secret';
                                    clientAuthController.getOtp(
                                        phone: _phoneController.text);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 15, left: 10, right: 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFCFCFC).withOpacity(0.8),
                          const Color(0xffffffff),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 8),
                          blurRadius: 10,
                          color: Color(0xFFE4EBEE),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _launchInstagram,
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          iconSize: 33,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 15, left: 10, right: 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFCFCFC).withOpacity(0.8),
                          const Color(0xffffffff),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 8),
                          blurRadius: 10,
                          color: Color(0xFFE4EBEE),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _launchPhone,
                          icon: const Icon(Icons.phone_enabled_outlined),
                          iconSize: 30,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 15, left: 10, right: 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFCFCFC).withOpacity(0.8),
                          const Color(0xffffffff),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 8),
                          blurRadius: 10,
                          color: Color(0xFFE4EBEE),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _launchWebsite,
                          icon: const Icon(Icons.language),
                          iconSize: 30,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 70),
              GestureDetector(
                onTap: _launchCompanyWebsite,
                child: Column(
                  children: [
                    Text(
                      'Designed by ',
                      style: const TextStyle(
                        color: AppColors.shadow,
                        fontSize: 11,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      'BAPS',
                      style: const TextStyle(
                        color: AppColors.background,
                        fontSize: 13,
                        fontFamily: 'Cairo',
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
