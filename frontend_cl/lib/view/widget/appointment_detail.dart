import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view/widget/Layout/appbar_drawer.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:frontend/view_model/petservice_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

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

  Future<void> _refreshData() async {
    setState(() {
      pet = PetViewModel().getPet(widget.appointment?.idThuCung);
      service =
          PetserviceViewModel().getService(widget.appointment?.loaiDichVu);
    });
  }

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < images.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
    String currentStatus = widget.appointment?.trangThai ?? "Chưa xác nhận";
    print(currentStatus);
    return Scaffold(
      appBar: const AppbarDrawer(title: 'Chi tiết lịch hẹn'),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildTimelineTile(
                      isFirst: true,
                      isLast: false,
                      status: "Chưa xác nhận",
                      label: "Đã đặt lịch hẹn",
                      isActive: currentStatus == "Chưa xác nhận" ||
                          currentStatus == "Đã xác nhận" ||
                          currentStatus == "Đã khám" ||
                          currentStatus == "Hoàn thành",
                    ),
                    buildTimelineTile(
                      isFirst: false,
                      isLast: false,
                      status: "Đã xác nhận",
                      label: "Đã xác nhận",
                      isActive: currentStatus == "Đã xác nhận" ||
                          currentStatus == "Đã khám" ||
                          currentStatus == "Hoàn thành",
                    ),
                    buildTimelineTile(
                      isFirst: false,
                      isLast: false,
                      status: "Đã khám",
                      label: "Đã khám",
                      isActive: currentStatus == "Đã khám" ||
                          currentStatus == "Hoàn thành",
                    ),
                    buildTimelineTile(
                      isFirst: false,
                      isLast: true,
                      status: "Hoàn thành",
                      label: "Hoàn thành",
                      isActive: currentStatus == "Hoàn thành",
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
                        const SizedBox(height: 15),
                        CarouselSlider(
                          items: images
                              .map((e) => SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      e,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            initialPage: 0,
                            viewportFraction: 1,
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
                        const SizedBox(height: 15),
                        buildCarouselIndicator(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              child: Text(
                                "Thông tin thú cưng",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
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
                                  Text(DateFormat("dd/MM/yyyy")
                                      .format(petItem?.ngaySinh as DateTime)),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 25),
                          child: Text(
                            "Thông tin dịch vụ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
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
                              Text(DateFormat("dd/MM/yyyy").format(
                                  widget.appointment?.ngayKham as DateTime)),
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTimelineTile({
  required bool isFirst,
  required bool isLast,
  required String status,
  required String label,
  required bool isActive,
  IconData? iconData,
}) {
  return TimelineTile(
    isFirst: isFirst,
    isLast: isLast,
    alignment: TimelineAlign.center,
    axis: TimelineAxis.horizontal,
    beforeLineStyle: LineStyle(
      color: isActive ? const Color(0xFFF48B29) : const Color(0xFFB0BEC5),
      thickness: 2,
    ),
    indicatorStyle: IndicatorStyle(
      iconStyle: isActive
          ? IconStyle(
              iconData: iconData ?? Icons.check,
              color: Colors.white,
              fontSize: 13,
            )
          : null,
      width: 20,
      height: 20,
      color: isActive ? const Color(0xFFF48B29) : const Color(0xFFB0BEC5),
    ),
    endChild: Container(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? const Color(0xFFF48B29) : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
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
