import 'package:flutter/material.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/petprofile_screen.dart';
import 'package:frontend/view/widget/Products/List_products.dart';
import 'package:frontend/view/widget/Products/List_vaccine.dart';
import 'package:frontend/view/widget/spash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Products());
  }
}
