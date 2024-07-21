import 'package:flutter/material.dart';
import 'package:frontend/view/widget/utils/Notification.dart';
import 'package:frontend/view/widget/utils/notification_item.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  const MyAppBar({super.key, required this.title});
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  void showTopSheet(BuildContext context, Widget child) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.topCenter,
          child: CustomTopSheet(child: child),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.white,
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
              onPressed: () {
                showTopSheet(
                  context,
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return const NotificationItem();
                        },
                      ),
                    ],
                  ),
                );
              },
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
