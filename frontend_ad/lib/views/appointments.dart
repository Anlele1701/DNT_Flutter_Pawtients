import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ad/models/appointment.dart';
import 'package:frontend_ad/views/items/appointment_item.dart';
import 'package:frontend_ad/views_models/appointment_view_model.dart';
import 'package:frontend_ad/views_models/pet_services_view_model.dart';
import 'package:frontend_ad/views_models/pet_view_model.dart';
import 'package:provider/provider.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Appointments> {
  AppointmentViewModel appointmentViewModel = AppointmentViewModel();
  Future<List<Appointment?>?> getAppointmentList() async {
    List<Appointment?>? appointments= await appointmentViewModel.getAppointmentList();
    return appointments;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Appointment?>?>(
          future: getAppointmentList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('Không có khách hàng nào'),
              );
            } else {
              final items = snapshot.data;
              return ListView.builder(
                itemCount: items?.length,
                itemBuilder: (context, index){
                  return AppointmentItem(appointment: items?[index]);
                },
              );
            }
          }),
      backgroundColor: Color(0xffF8F8F8),
    );
  }
}
