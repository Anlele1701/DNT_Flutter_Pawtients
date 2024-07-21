import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key});

  @override
  State<NotificationItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NotificationItem> {
  String a = "hello";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Stack(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 25,
                      backgroundImage: AssetImage('images/cat.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Khám bệnh",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                        ))
                  ],
                ),
                const Positioned(
                  top: 40,
                  right: 5,
                  child: Text(
                    "23:43 - 1/6/2024",
                    style: TextStyle(color: Color(0xffABABAB)),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: a == "hello"
                  ? CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 8,
                    )
                  : SizedBox.shrink()),
        ],
      ),
    );
  }
}
