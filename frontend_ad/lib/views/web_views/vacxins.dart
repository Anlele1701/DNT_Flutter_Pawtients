import 'package:flutter/material.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';

class Vacxins extends StatefulWidget {
  const Vacxins({super.key});

  @override
  State<Vacxins> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Vacxins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}