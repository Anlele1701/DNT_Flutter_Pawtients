import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(Colors.white),
          ),
        )
      ],
      title: const Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundColor: Colors.red,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NGUYỄN TIẾN THÀNH",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Bác sĩ",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
}