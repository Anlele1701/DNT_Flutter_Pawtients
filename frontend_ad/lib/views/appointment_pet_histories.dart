import 'package:flutter/material.dart';
import 'package:frontend_ad/views/items/appointment_pet_item.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';

class AppointmentPetHistory extends StatefulWidget {
  const AppointmentPetHistory({super.key});

  @override
  State<AppointmentPetHistory> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentPetHistory> {
  final List<AppointmentPetItem> items = List.generate(
    10,
    (index) => const AppointmentPetItem(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return AppointmentPetItem();
        },
        ),
      backgroundColor: Color(0xffF8F8F8),
    );
  }
}