import 'package:flutter/material.dart';

class AppbarDrawer extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarDrawer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(color: Colors.white),
      backgroundColor: const Color(0xffFB7E09),
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
