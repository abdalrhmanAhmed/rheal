import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/user_data_controller.dart';
import '../../controllers/warning_Controller.dart';
import '../console_screens/console_home_screen.dart';
import '../helpers/theme_helper.dart';
import '../helpers/widgets/numbers_widget.dart';

class prof extends StatefulWidget {
  prof({Key? key}) : super(key: key);

  @override
  State<prof> createState() => _profState();
}

class _profState extends State<prof> {
  final userDatacontroller = Get.put(UserDataContoller());
  late GlobalKey<ScaffoldState> _scaffoldKey;
  File? image;
  Future pickImageg() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('feld to pick image : $e');
    }
  }

  Future pickImagec() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('feld to pick image : $e');
    }
  }

  @override
  void initState() {
    userDatacontroller.getUserData();
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
          body: Obx(
            () {
              return userDatacontroller.isLoding.value == false
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
                              userDatacontroller.getUserData();
                            });
                            // _scaffoldKey.currentState!.showSnackBar(
                            //   SnackBar(
                            //     content: const Text('تم تحديث البيانات بنجاح'),
                            //   ),
                            // );
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
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        color: Colors.white,
                                        boxShadow: [
                             
                                        ],
                                      ),
                                      child: image != null
                                          ? Container(
                                              width: 130,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: FileImage(image!),
                                                ),
                                              ),
                                            )
                                          : userDatacontroller
                                                      .userData.value.id ==
                                                  null
                                              ? IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.person),
                                                  iconSize: 80,
                                                  color: Colors.black12,
                                                )
                                              : Container(
                                                  width: 120,
                                                  height: 120,
                                                  child: CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://admin.shurasd.com/upload/catiguriesIcon/${userDatacontroller.userData.value.id}',
                                                    ),
                                                  ),
                                                ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 100, 0, 0),
                                        child: Icon(
                                          Icons.change_circle_sharp,
                                          color: Colors.blue.shade700,
                                          size: 35.0,
                                        ),
                                      ),
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog(context),
                                      ),
                                    ),
                                    if (userDatacontroller
                                            .userData.value.id ==
                                        1)
                                      InkWell(
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 105, 0),
                                          child: Icon(
                                            Icons.supervised_user_circle,
                                            color: Color.fromARGB(
                                                255, 73, 241, 160),
                                            size: 35.0,
                                          ),
                                        ),
                                        onTap: () => Get.to(
                                          () => ConsoleHomeScreen(),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              // end avatar icon
                              SizedBox(height: 10),
                              // start name filed
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                5, 18, 35, 10),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 30, 0),
                                            child: Icon(
                                              Icons.change_circle_sharp,
                                              color: Colors.blue.shade700,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${userDatacontroller.userData.value.name}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                221, 555, 555, 555),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // end name filed
                              SizedBox(height: 10),
                              // start user info
                              GestureDetector(
                                  child: NumbersWidget(
                                country:
                                    "UAE",
                                isActiv:
                                    userDatacontroller.userData.value.id,
                                type: userDatacontroller.userData.value.id,
                              )),
                              // end user info
                              SizedBox(height: 20),
                              // start email and password filed
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        // controller: _userName,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                '${userDatacontroller.userData.value.email}',
                                                'يمكنك تعديل إيميلك من هنا'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'لا يمكنك ترك الإيميل فارغا';
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        // controller: _userName,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('كلمة المرور',
                                                'يمكنك تعديل كلمة مرورك من هنا'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'لا يمكنك ترك كلمة المرور فارغا';
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        // controller: _userName,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                "${userDatacontroller.userData.value.phone}",
                                                'يمكنك تعديل رقم هاتفك من هنا'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'لا يمكنك ترك كلمة المرور فارغا';
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                  ],
                                ),
                              ),
                              // end email and password filed
                              SizedBox(height: 20),
                              // start send button
                              GestureDetector(
                                child: Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "حفظ التعديلات".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      WarningController().underDev('home');
                                      // if (_formKey.currentState!.validate()) {
                                      //   _registerData['name'] = _userName.text;
                                      //   _registerData['email'] =
                                      //       _emailController.text;
                                      //   _registerData['password'] =
                                      //       _passwordController.text;
                                      //   _registerData['phone'] = _userPhone.text;
                                      //   _registerData['country'] = "Sudan";
                                      //   _registerData['gendor'] = 1;
                                      //   _registerData['type'] = 1;
                                      //   image == null
                                      //       ? print("no image")
                                      //       : _registerData['photo'] = {
                                      //           'file_name':
                                      //               image!.path.split('/').last,
                                      //           'file_path': image!.path
                                      //         };
                                      //   clientAuthController.register(
                                      //       registerData: _registerData,
                                      //       files: {'photo': image!});
                                      // }
                                    },
                                  ),
                                ),
                              )
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

  Widget _buildPopupDialog(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new AlertDialog(
        title: const Text(
          'إختيار الصورة عن طريق ...',
          style: TextStyle(
            color: Color.fromARGB(255, 555, 555, 555),
          ),
        ),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(
                  width: 12.0,
                ),
          
              ],
            )
          ],
        ),
      ),
    );
  }
}
