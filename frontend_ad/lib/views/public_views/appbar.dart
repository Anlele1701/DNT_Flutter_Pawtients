import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/auth_services.dart';
import 'package:frontend_ad/views/items/appointment_item.dart';
import 'package:frontend_ad/views/items/notification_item.dart';
import 'package:frontend_ad/views/public_views/notification_top_sheet.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String hoten="";
  late String chucVu="";
  final List<NotificationItem> items = List.generate(
    5,
    (index) => const NotificationItem(),
  );
  @override
  void initState() {
    super.initState();
    AuthServices().getInfo().then((value) {
      setState(() {
        hoten = value['hoTen'];
        chucVu = value['chucVu'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showTopSheet(
              context,
              Stack(
                children: [
                  ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return NotificationItem();
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Xem tất cả",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ))
                ],
              ),
            );
          },
          icon: const Icon(Icons.notifications),
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(Colors.white),
          ),
        )
      ],
      title: Row(
        children: [
          const SizedBox(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundColor: Colors.red,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hoten,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                chucVu,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xffF48B29),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);

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
          child: Container(child: CustomTopSheet(child: child)),
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
}
