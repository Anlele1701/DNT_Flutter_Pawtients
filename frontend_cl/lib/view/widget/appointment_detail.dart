import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key, this.appointment});
  final Appointment? appointment;

  @override
  State<AppointmentDetail> createState() => AppointmentDetailState();
}

class AppointmentDetailState extends State<AppointmentDetail> {
  final List<String> images = [
    'assets/images/appoint_detail_demo.png',
    'assets/images/appoint_detail_demo.png',
    'assets/images/appoint_detail_demo.png',
  ];

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < images.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i == banner_cur ? 3 : 3,
            width: i == banner_cur ? 20 : 15,
            decoration: BoxDecoration(
              color: i == banner_cur ? const Color(0xFFF48B29) : Colors.grey,
              shape: BoxShape.rectangle,
            ),
          )
      ],
    );
  }

  int banner_cur = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          title: "",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                items: images
                    .map((e) => Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(e),
                        ))
                    .toList(),
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (value, reason) {
                    setState(() {
                      banner_cur = value;
                    });
                  },
                ),
              ),
            ),
            buildCarouselIndicator(),
            Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thông tin thú cưng",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Tên thú cưng",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Mi Mi"),
                          Line(),
                          const Text(
                            "Loại",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Mèo"),
                          Line(),
                          const Text(
                            "Giống loài",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Mèo ta"),
                          Line(),
                          const Text(
                            "Ngày sinh",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("04/10/2003"),
                          Line(),
                          const Text(
                            "Cân nặng",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("4,3 kg"),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thông tin lịch khám",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Dịch vụ",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Khám bệnh"),
                          Line(),
                          const Text(
                            "Ngày khám",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("08/06/2024"),
                          Line(),
                          const Text(
                            "Tên nhân viên",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Lê Thoại Bảo Ngọc"),
                          Line(),
                          const Text(
                            "Chức vụ",
                            style: TextStyle(color: Color(0xFF697288)),
                          ),
                          const Text("Bác sĩ phẫu thuật"),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Widget Line() {
  return const Divider(
    color: Colors.grey, // Set the color of the line
    thickness: 0.3, // Set the thickness of the line
  );
}
