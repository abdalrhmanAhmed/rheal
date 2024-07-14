import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/appointments_screens/CemeteryContactScreen.dart';
import 'package:rheal/view/appointments_screens/media/media_home.dart';

import '../../controllers/cemetery_detail_controller.dart';

class CemeteryDetail extends StatefulWidget {
  final int id;
  final String name;
  CemeteryDetail({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);
  @override
  _CemeteryDetailState createState() => _CemeteryDetailState();
}

class _CemeteryDetailState extends State<CemeteryDetail> {
  final cemetery_detail_Controller = Get.put(CemeteryDetailController());

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    cemetery_detail_Controller.getCemeteryDetail(widget.id);
    super.initState();
  }

  double get initialLatitude =>
      cemetery_detail_Controller.cemetery_detail.value.lat as double;

  double get initialLongitude =>
      cemetery_detail_Controller.cemetery_detail.value.long as double;

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
              widget.name,
              style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: AppColors.text),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  AppColors.background,
                  AppColors.background,
                ])),
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
            return cemetery_detail_Controller.isLoding.value == false
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.background,
                    color: AppColors.text,
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          setState(() {
                            cemetery_detail_Controller
                                .getCemeteryDetail(widget.id);
                          });
                        },
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          mapType: MapType.hybrid,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(initialLatitude, initialLongitude),
                            zoom: 18.0,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position:
                                  LatLng(initialLatitude, initialLongitude),
                              infoWindow: InfoWindow(
                                title: widget.name,
                                snippet: cemetery_detail_Controller
                                    .cemetery_detail.value.name,
                              ),
                            ),
                          },
                        ),
                        Positioned(
                          bottom: 100.0,
                          left: 20.0,
                          right: 20.0,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'بيانات عامة',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text('الاسم:  ${widget.name ?? "فارغ"}'),
                                  Text(
                                      'نبذة:  ${cemetery_detail_Controller.cemetery_detail.value.text ?? "فارغ"}'),
                                  SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors
                                              .background, // Change this to the desired background color
                                        ),
                                        onPressed: () {
                                          // Add your button functionality here
                                          Get.to(CemeteryContactScreen(
                                              id: cemetery_detail_Controller
                                                  .cemetery_detail.value.id));
                                        },
                                        child: Text(
                                          'التواصل',
                                          style:
                                              TextStyle(color: AppColors.text),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors
                                              .background, // Change this to the desired background color
                                        ),
                                        onPressed: () {
                                          Get.to(MediaHomeScreen5(
                                              name: cemetery_detail_Controller
                                                  .cemetery_detail.value.name,
                                              id: cemetery_detail_Controller
                                                  .cemetery_detail.value.id));
                                        },
                                        child: Text(
                                          'عرض الوسائط',
                                          style:
                                              TextStyle(color: AppColors.text),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
