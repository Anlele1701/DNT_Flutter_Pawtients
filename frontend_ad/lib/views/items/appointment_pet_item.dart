import 'package:flutter/material.dart';

class AppointmentPetItem extends StatefulWidget {
  const AppointmentPetItem({super.key});

  @override
  State<AppointmentPetItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentPetItem> {
  String a="hello";
  String b="Xem kết quả khám bện";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.fromLTRB(10,15,10,15),
            margin: const EdgeInsets.fromLTRB(16,10,16,10),
            child: Stack(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Khám bệnh",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                          Text("9:00 - 20/7/2024",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: b=="Đã xác nhận"?const Text("Đã xác nhận", style: TextStyle(color: Color(0xff00FF29), fontWeight: FontWeight.bold),)
                            : b=="Xem kết quả khám bệnh"?TextButton(onPressed: (){}, child: const Text("Xem kết quả khám bệnh", style: TextStyle(color: Color(0xffF48B29), fontWeight: FontWeight.bold),))
                            : b=="Đã hủy"?const Text("Đã hủy", style: TextStyle(color: Color(0xffBD0000), fontWeight: FontWeight.bold),)
                            : IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_arrow_right, size: 40,))
                    )
                  ],
                ),
                const Positioned(
                  top: 47,
                  right: 5,
                  child: Text("23:43 - 1/6/2024", style: TextStyle(color: Color(0xffABABAB)),),
                )
              ],
            ),
          ),
          Positioned(
            top:5,
            right: 10,
            child: a=="hello"?CircleAvatar(backgroundColor: Colors.red, radius: 8,):SizedBox.shrink()
            ),
        ],
      ),
    );
  }
}
