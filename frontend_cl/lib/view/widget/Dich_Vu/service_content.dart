import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> getItems() {
  return [
    "Khám tại nhà",
    "X-Quang",
    "Xét nghiệm",
    "Khám tổng quát",
    "Tiêm phòng",
    "Triệt sản",
  ];
}

List<String> getIcons() {
  return [
    "assets/icons/House.png",
    "assets/icons/Bone.png",
    "assets/icons/Exp.png",
    "assets/icons/General.png",
    "assets/icons/Inject.png",
    "assets/icons/Surgial.png",
  ];
}

List<String> getPicture() {
  return [
    "assets/images/Pic1_service.png",
    "assets/images/Pic2_service.png",
    "assets/images/Pic3_service.png",
    "assets/images/Pic4_service.png",
    "assets/images/Pic5_service.png",
    "assets/images/Pic6_service.png",
  ];
}

List<String> getContent() {
  return [
    "Bạn đang bận rộn với công việc? Bạn lo lắng khi đưa thú cưng đến phòng khám vì sợ lây bệnh? Dịch vụ khám thú cưng tại nhà chính là giải pháp dành cho bạn! Dịch vụ khám thú cưng tại nhà mang đến nhiều lợi ích thiết thực, giúp bạn tiết kiệm thời gian, công sức và mang đến trải nghiệm khám chữa bệnh thoải mái, an toàn cho thú cưng.",
    """Dịch vụ chụp X-quang cho thú cưng: Chẩn đoán chính xác, điều trị hiệu quả! Chụp X-quang là kỹ thuật chẩn đoán hình ảnh y tế sử dụng tia X để tạo ra hình ảnh chi tiết về cấu trúc bên trong cơ thể, bao gồm xương, khớp, cơ bắp, các cơ quan nội tạng,... Kỹ thuật này đóng vai trò quan trọng trong việc chẩn đoán và điều trị các bệnh lý ở thú cưng.
    """,
    """Dịch vụ xét nghiệm cho thú cưng - Bảo vệ sức khỏe toàn diện cho người bạn bốn chân! Tương tự như con người, thú cưng cũng cần được chăm sóc sức khỏe định kỳ và sử dụng dịch vụ xét nghiệm để phát hiện sớm bệnh tật, theo dõi tình trạng sức khỏe và hỗ trợ chẩn đoán, điều trị hiệu quả. Hãy sử dụng dịch vụ ngay để có thể phòng tránh các bệnh sớm nhất có thể.
    """,
    """Khám tổng quát cho thú cưng - Việc làm thiết yếu cho sức khỏe toàn diện! Khám tổng quát là việc kiểm tra sức khỏe toàn diện cho thú cưng, bao gồm kiểm tra lâm sàng, xét nghiệm và các chẩn đoán bổ sung khác (nếu cần thiết) nhằm đánh giá tình trạng sức khỏe hiện tại của thú cưng, phát hiện sớm các bệnh lý tiềm ẩn và đưa ra biện pháp phòng ngừa phù hợp.
    """,
    """Dịch vụ tiêm phòng cho thú cưng - Lá chắn bảo vệ sức khỏe toàn diện! Tiêm phòng cho thú cưng là việc tiêm vắc-xin để giúp chúng phòng ngừa các bệnh truyền nhiễm nguy hiểm. Đây là biện pháp thiết yếu để bảo vệ sức khỏe cho thú cưng, giúp chúng có một cuộc sống khỏe mạnh và hạnh phúc. Cũng như là bảo vệ bản thân bạn và cho cả cộng đồng.
    """,
    """Dịch vụ triệt sản cho thú cưng: Giải pháp hiệu quả cho việc kiểm soát sinh sản và sức khỏe! Triệt sản cho thú cưng là một phẫu thuật loại bỏ buồng trứng ở con cái hoặc tinh hoàn ở con đực. Đây là biện pháp hiệu quả để kiểm soát sinh sản và mang lại nhiều lợi ích cho sức khỏe của thú cưng. Đảm bảo không có di chứng về sau cho thú cưng của bạn,
    """
  ];
}

List<String> advantageTexts1 = [
  "Tiết kiệm thời gian di chuyển",
  "Giảm bớt căng thẳng cho thú cưng",
  "Chăm sóc tận tâm và chu đáo",
  "An toàn và giảm thiểu nguy cơ lây nhiễm"
];

List<String> advantageTexts2 = [
  "Đánh giá mức độ nghiêm trọng",
  "Chẩn đoán chính xác, trị đúng bệnh",
  "Theo dõi tiến trình điều trị",
  "Giảm thiểu nguy cơ biến chứng"
];

List<String> advantageTexts3 = [
  "Chẩn đoán bệnh lý sớm nhất",
  "Theo dõi sức khỏe tổng thể",
  "Phát hiện điều trị bệnh lý",
  "Lập kế hoạch chăm sóc sức khỏe"
];

List<String> advantageTexts4 = [
  "Chẩn đoán chính xác bệnh tình",
  "Theo dõi sức khỏe của vật nuôi",
  "Phòng ngừa bệnh tật, virus",
  "Phát hiện các vấn đề hành vi"
];

List<String> advantageTexts5 = [
  "Phòng ngừa bệnh truyền nhiễm",
  "Giảm nguy cơ tử vong của vật nuôi",
  "Bảo vệ sức khỏe cộng đồng",
  "Tiết kiệm chi phí điều trị"
];

List<String> advantageTexts6 = [
  "Giảm nguy cơ mắc bệnh ở vật nuôi",
  "Giảm nguy cơ đi lang thang",
  "Giảm chi phí chăm sóc thú cưng",
  "Giảm nguy cơ bị tấn công bởi thú cưng"
];

List<Row> advantage1 = List.generate(
    4,
    (index) => Row(children: [
          Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
          SizedBox(
            width: 5,
          ),
          Text(advantageTexts1[index],style: TextStyle(fontSize: 16),),
        ]));

List<Row> advantage2 = List.generate(
    4,
    (index) => Row(
          children: [
            Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
            SizedBox(
              width: 5,
            ),
            Text(advantageTexts2[index],style: TextStyle(fontSize: 16),)
          ],
        ));

List<Row> advantage3 = List.generate(
    4,
    (index) => Row(
          children: [
            Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
            SizedBox(
              width: 5,
            ),
            Text(advantageTexts3[index],style: TextStyle(fontSize: 16),)
          ],
        ));
List<Row> advantage4 = List.generate(
    4,
    (index) => Row(
          children: [
            Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
            SizedBox(
              width: 5,
            ),
            Text(advantageTexts4[index],style: TextStyle(fontSize: 16),)
          ],
        ));
List<Row> advantage5 = List.generate(
    4,
    (index) => Row(
          children: [
            Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
            SizedBox(
              width: 5,
            ),
            Text(advantageTexts5[index],style: TextStyle(fontSize: 16),)
          ],
        ));
List<Row> advantage6 = List.generate(
    4,
    (index) => Row(
          children: [
            Icon(Icons.assistant_photo,size: 26,color: Color(0xFF4E80CB),),
            SizedBox(
              width: 5,
            ),
            Text(advantageTexts6[index],style: TextStyle(fontSize: 16),)
          ],
        ));

List<Row> Advantages(int x) {
  switch (x) {
    case 0:
      return advantage1;
    case 1:
      return advantage2;
    case 2:
      return advantage3;
    case 3:
      return advantage4;
    case 4:
      return advantage5;
    default:
      return advantage6;
  }
}
