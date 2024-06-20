import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("khách hàng"),),
    );
  }
}