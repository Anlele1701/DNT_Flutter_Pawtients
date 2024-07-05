import 'package:flutter/material.dart';
import 'package:frontend_ad/views/appointment_pet_histories.dart';
import 'package:frontend_ad/views/login_screen.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:frontend_ad/views/public_views/bottom_nav.dart';
import 'package:frontend_ad/views/web_views/create_pet_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //home: BottomNav(),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
