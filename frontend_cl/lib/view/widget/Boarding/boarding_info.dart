import 'package:flutter/foundation.dart';

class BoardingInfo {
  final String title;
  final String Description;
  final String image;
  BoardingInfo(
      {required this.title, required this.Description, required this.image});
}

class BoardingItem {
  List<BoardingInfo> items = [
    BoardingInfo(title: "Khám Bệnh", Description: "Khám bệnh tận tâm, sức khỏe vẹn toàn.", image: "assets/images/boarding_6.png"),
    BoardingInfo(title: "Uy Tín", Description: "Dịch vụ cao cấp, thú y chuyên nghiệp.", image: "assets/images/boarding_11.png"),
    BoardingInfo(title: "Bảo Vệ", Description: "Bảo vệ sức khỏe, lan tỏa yêu thương.", image: "assets/images/boarding_7.png"),
    BoardingInfo(title: "Sắc Đẹp", Description: "Làm đẹp nhanh chống, tự tin rạng ngời.", image: "assets/images/boarding_3.png"),
  ];
}
