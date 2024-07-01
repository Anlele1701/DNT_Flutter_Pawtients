import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ad/views/items/appointment_item.dart';
import 'package:provider/provider.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Appointments> {
  final List<AppointmentItem> items = List.generate(
    10,
    (index) => const AppointmentItem(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return AppointmentItem();
        },
        ),
      backgroundColor: Color(0xffF8F8F8),
    );
  }
}