import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  MyAppBar({super.key, required this.title});
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6F6F6),
        leading: IconButton(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            onPressed: () {},
            icon: const Icon(
              Icons.menu_rounded,
              weight: 400,
              opticalSize: 30,
              size: 30,
            )),
        title: Center(
          child: Text(
            widget.title ?? "",
            style: const TextStyle(
                color: Color(0xff474747),
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                weight: 400,
                opticalSize: 30,
                size: 30,
              ))
        ],
      ),
    );
  }
}
