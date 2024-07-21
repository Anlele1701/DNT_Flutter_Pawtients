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
    BoardingInfo(title: "PAWTIENT", Description: "CHÀO MỪNG BẠN ĐẾN VỚI", image: "assets/images/boarding_6.png"),
    BoardingInfo(title: "", Description: "Thú cưng là những người bạn đồng hành đáng tin cậy và mang lại niềm vui, hạnh phúc cho gia đình. Để thú cưng luôn khỏe mạnh và tràn đầy năng lượng, việc chăm sóc sức khỏe cho chúng là vô cùng quan trọng.", image: "assets/images/boarding_7.png"),
    BoardingInfo(title: "", Description: "Hãy để chúng tôi đồng hành cùng bạn trong hành trình này, từ việc cung cấp dinh dưỡng phù hợp, thăm khám định kỳ cho đến các hoạt động vui chơi và rèn luyện của thú cưng.", image: "assets/images/boarding_3.png"),
  ];
}
