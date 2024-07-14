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
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xff474747),
              weight: 400,
              opticalSize: 30,
              size: 35,
            )),
      ),
      title: Center(
        child: Text(
          textAlign: TextAlign.center,
          widget.title ?? "",
          style: const TextStyle(
              color: Color(0xff474747),
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xff474747),
                weight: 400,
                opticalSize: 30,
                size: 35,
              )),
        )
      ],
    );
  }
}
