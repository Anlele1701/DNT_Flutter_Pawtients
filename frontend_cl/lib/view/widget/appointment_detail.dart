import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view/widget/Layout/appbar_drawer.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:frontend/view_model/petservice_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
  late Future<Pet?> pet;
  late Future<String?> service;

  @override
  void initState() {
    super.initState();
    pet = PetViewModel().getPet(widget.appointment?.idThuCung);
    service = PetserviceViewModel().getService(widget.appointment?.loaiDichVu);
  }

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < images.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: 3,
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
      appBar: const AppbarDrawer(title: 'Chi tiết lịch hẹn'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TimelineTile(
                    alignment: TimelineAlign.center,
                    axis: TimelineAxis.horizontal,
                    isFirst: true,
                    indicatorStyle: const IndicatorStyle(
                      width: 18,
                      height: 18,
                      color: Color(0xFFF48B29),
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Đã đặt lịch hẹn",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFF48B29),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.center,
                    axis: TimelineAxis.horizontal,
                    indicatorStyle: const IndicatorStyle(
                      width: 16,
                      height: 16,
                      color: Color(0xFFB0BEC5),
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Đã xác nhận",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.center,
                    axis: TimelineAxis.horizontal,
                    indicatorStyle: const IndicatorStyle(
                      width: 16,
                      height: 16,
                      color: Color(0xFFB0BEC5),
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Đã khám",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  TimelineTile(
                    isLast: true,
                    alignment: TimelineAlign.center,
                    axis: TimelineAxis.horizontal,
                    indicatorStyle: const IndicatorStyle(
                      width: 16,
                      height: 16,
                      color: Color(0xFFB0BEC5),
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Hoàn thành",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: pet,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerEffect();
                } else if (snapshot.hasError) {
                  return const Text("Error");
                } else {
                  final petItem = snapshot.data;
                  return Column(
                    children: [
                      CarouselSlider(
                        items: images
                            .map((e) => SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(e),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (value, reason) {
                            setState(() {
                              banner_cur = value;
                            });
                          },
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
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Tên thú cưng",
                                    style: TextStyle(color: Color(0xFF697288)),
                                  ),
                                  Text(petItem?.tenThuCung ?? "N/A"),
                                  Line(),
                                  const Text(
                                    "Loại",
                                    style: TextStyle(color: Color(0xFF697288)),
                                  ),
                                  Text(petItem?.loaiThuCung ?? "N/A"),
                                  Line(),
                                  const Text(
                                    "Giống loài",
                                    style: TextStyle(color: Color(0xFF697288)),
                                  ),
                                  Text(petItem?.giongLoai ?? "N/A"),
                                  Line(),
                                  const Text(
                                    "Ngày sinh",
                                    style: TextStyle(color: Color(0xFF697288)),
                                  ),
                                  Text(petItem?.ngaySinh.toString() ?? "N/A"),
                                  Line(),
                                  const Text(
                                    "Cân nặng",
                                    style: TextStyle(color: Color(0xFF697288)),
                                  ),
                                  Text("${petItem?.canNang} kg"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: service,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerEffect();
                }
                if (snapshot.hasError) {
                  return const Text("Error");
                } else {
                  final serviceItem = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(top: 30),
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thông tin dịch vụ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Tên dịch vụ",
                          style: TextStyle(color: Color(0xFF697288)),
                        ),
                        Text(serviceItem ?? "N/A"),
                        Line(),
                        const Text(
                          "Ngày khám",
                          style: TextStyle(color: Color(0xFF697288)),
                        ),
                        Text(widget.appointment?.ngayKham.toString() ?? "N/A"),
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
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
