import 'package:flutter/material.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:frontend_ad/views/public_views/bottom_nav.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNav(),
    );
  }
}
