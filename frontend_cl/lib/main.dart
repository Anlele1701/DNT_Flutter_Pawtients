import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/view/spash_screen.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF6F6F6)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));
  }
}
