import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/cemetery_detail_controller.dart';

class CemeteryDetail extends StatefulWidget {
  final int id;
  CemeteryDetail({
    Key? key,
    required this.id,
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
              "بيانات المقبرة",
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
                            zoom: 11.0,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('currentLocation'),
                              position:
                                  LatLng(initialLatitude, initialLongitude),
                              infoWindow: InfoWindow(
                                title: 'موقع المقبرة',
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
                                    'بيانات المقبرة',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                      'الاسم:  ${cemetery_detail_Controller.cemetery_detail.value.name ?? "فارغ"}'),
                                  Text(
                                      'نبذة:  ${cemetery_detail_Controller.cemetery_detail.value.text ?? "فارغ"}'),
                                  SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your button functionality here
                                        },
                                        child: Text('Button 1'),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your button functionality here
                                        },
                                        child: Text('Button 2'),
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
