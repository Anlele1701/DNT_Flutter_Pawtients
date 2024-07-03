import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key});

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
              color: i == banner_cur ? Color(0xFFF48B29) : Colors.grey,
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
      appBar: PreferredSize(
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
                          child: Image.asset(e),
                        ))
                    .toList(),
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 3),
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
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thông tin khách hàng",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                          SizedBox(height: 20,),
                          Text("Mã khách hàng",style: TextStyle(color: Color(0xFF697288)),),
                          Text("1012349584955"),
                          Line(),
                          Text("Họ và tên",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Lê Thành Duy Ân"),
                          Line(),
                          Text("Số điện thoại",style: TextStyle(color: Color(0xFF697288)),),
                          Text("0702176453"),
                          Line(),
                          Text("Email",style: TextStyle(color: Color(0xFF697288)),),
                          Text("lethanhduyan@gmail.com"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thông tin thú cưng",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                          SizedBox(height: 20,),
                          Text("Tên thú cưng",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Mi Mi"),
                          Line(),
                          Text("Loại",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Mèo"),
                          Line(),
                          Text("Giống loài",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Mèo ta"),
                          Line(),
                          Text("Ngày sinh",style: TextStyle(color: Color(0xFF697288)),),
                          Text("04/10/2003"),
                          Line(),
                          Text("Cân nặng",style: TextStyle(color: Color(0xFF697288)),),
                          Text("4,3 kg"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thông tin lịch khám",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                          SizedBox(height: 20,),
                          Text("Dịch vụ",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Khám bệnh"),
                          Line(),
                          Text("Ngày khám",style: TextStyle(color: Color(0xFF697288)),),
                          Text("08/06/2024"),
                          Line(),
                          Text("Tên nhân viên",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Lê Thoại Bảo Ngọc"),
                          Line(),
                          Text("Chức vụ",style: TextStyle(color: Color(0xFF697288)),),
                          Text("Bác sĩ phẫu thuật"),
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
  return Divider(
    color: Colors.grey, // Set the color of the line
    thickness: 0.3, // Set the thickness of the line
  );
}
