import 'package:flutter/material.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hóa đơn"),),
    );
  }
}