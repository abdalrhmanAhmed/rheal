import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:utm/utm.dart';

import '../../controllers/cemetery_detail_controller.dart';

class Grave extends StatefulWidget {
  final int id;
  Grave({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _CemeteryDetailState createState() => _CemeteryDetailState();
}

class _CemeteryDetailState extends State<Grave> {
  final cemetery_detail_Controller = Get.put(GraveController());

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    cemetery_detail_Controller.getGrave(widget.id);
    super.initState();
  }

  LatLng get initialLatLng {
    double easting = cemetery_detail_Controller.graveModel.value.easting;
    double northing = cemetery_detail_Controller.graveModel.value.northing;
    return convertUTMToLatLng(easting, northing);
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
              "بيانات القبر",
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
                    color: AppColors.text.withAlpha(59),
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          setState(() {
                            cemetery_detail_Controller.getGrave(widget.id);
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
                            target: initialLatLng,
                            zoom: 18.0,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position: initialLatLng,
                              infoWindow: InfoWindow(
                                title: 'موقع قبر المرحوم',
                                snippet: cemetery_detail_Controller
                                    .graveModel.value.name,
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
                                    'بيانات القبر',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                      'الاسم:  ${cemetery_detail_Controller.graveModel.value.name ?? "فارغ"}'),
                                  Text(
                                      'إسم المقبرة:  ${cemetery_detail_Controller.graveModel.value.cemetery_name ?? "فارغ"}'),
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

  LatLng convertUTMToLatLng(double easting, double northing) {
    // Assuming UTM Zone 33N and northern hemisphere
    var latLon = UTM.fromUtm(
      easting: easting,
      northing: northing,
      zoneNumber: 40,
      zoneLetter: 'N',
    );
    return LatLng(latLon.lat, latLon.lon);
  }
}
