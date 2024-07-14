import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/controllers/console/console_orders_controller.dart';
import 'package:rheal/models/client/client_apointment_model.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/appointments_screens/cemetery_detail.dart';

class Appointments extends StatefulWidget {
  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final clientController = Get.put(ConsoleOrdersController());

  @override
  void initState() {
    super.initState();
    clientController.clientOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return clientController.isLoding.value
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
                        clientController.clientOrders();
                      },
                    );
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.42,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: clientController.clientApointment.length,
                    itemBuilder: (context, index) {
                      return buildAppointment(
                          clientController.clientApointment[index]);
                    },
                  ),
                );
        },
      ),
    );
  }

  Widget buildAppointment(ClientApointmentModel appointment) {
    return InkWell(
      onTap: () {
        Get.to(CemeteryDetail(
          id: appointment.id,
          name: appointment.name,
        ));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: AppColors.background.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://cemetery2.bmwit.com/public/cemetery_sites-profile/${appointment.image}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "مقبرة ${appointment.name}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
