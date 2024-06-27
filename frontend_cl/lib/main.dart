import 'package:flutter/material.dart';
import 'package:frontend/view/addpetprofile_screen.dart';
import 'package:frontend/view/booking_screen.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/petprofile_screen.dart';
import 'package:frontend/view/spash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF6F6F6)),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
