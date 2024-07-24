import 'package:flutter/material.dart';
import 'package:frontend_ad/views/appointment_detail.dart';

class AppointmentItem extends StatefulWidget {
  const AppointmentItem({super.key});

  @override
  State<AppointmentItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentItem> {
  String a = "hello";
  String b = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(blurRadius: 0.1, offset: Offset(0.5, 0.5))
                ]),
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
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
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        "9:00 - 20/7/2024",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Column(children: [
                      b == "Đã xác nhận"
                          ? const Text(
                              "Đã xác nhận",
                              style: TextStyle(
                                  color: Color(0xff00FF29),
                                  fontWeight: FontWeight.bold),
                            )
                          : b == "Xem kết quả khám bệnh"
                              ? TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Xem kết quả khám bệnh",
                                    style: TextStyle(
                                        color: Color(0xffF48B29),
                                        fontWeight: FontWeight.bold),
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentDetail()));
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 33,
                                  )),
                      Text(
                        "23:43 - 1/6/2024",
                        style: TextStyle(color: Color(0xffABABAB)),
                      ),
                    ])),
              ],
            ),
          ),
          Positioned(
              top: 5,
              right: 10,
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
