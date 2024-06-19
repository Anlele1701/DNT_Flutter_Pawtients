import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePage();
}

class _ServicePage extends State<ServicePage> {
  List<String> items = [
    "Khám tại nhà",
    "X-Quang",
    "Xét nghiệm",
    "Khám tổng quát",
    "Tiêm phòng",
    "Triệt sản",
  ];
  List<String> icons = [
    "assets/icons/House.png",
    "assets/icons/Bone.png",
    "assets/icons/Exp.png",
    "assets/icons/General.png",
    "assets/icons/Inject.png",
    "assets/icons/Surgial.png",
  ];

  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Đây là header"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // tạo ra một khung để chia ra các tab
              SizedBox(
                //* chỉnh độ dài của các tab tại đây vì đây là một tab dài cắt nhỏ
                  height: 80,
                  width: double.infinity,
                  child: ListView.builder(
                    //scroll theo chiều ngang
                    scrollDirection: Axis.horizontal,
                    //* physics thêm các hiệu ứng scroll như scroll có thể kéo dản khi hết content,
                    //* hoặc không cho scroll khi hết content
                    physics: BouncingScrollPhysics(),
                    //*gắn thêm itemcount để nó bt số lượng item cần hiện không bị lỗi UI
                    itemCount: items.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            count = index;
                          });
                        },
                        //*sử dụng AnimatedContainer để tạo ra hiệu ứng click vào ra màu không thì xám
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          //margin này để tách các tab ra
                          margin: EdgeInsets.all(5),
                          // width này để tạo chiều rộng tab
                          width: 120,
                          height: 45,
                          decoration: BoxDecoration(
                            gradient : count == index? 
                            LinearGradient(
                              colors: [Color(0xFFF1B237),Color(0xFFFB7E09)],
                              stops: [0.12,1],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              )
                            :LinearGradient(colors: [Color(0xFFD7C7B7),Color(0xFFD7C7B7)]),
                            borderRadius: BorderRadius.circular(15),
                            ),
                          child: Center(
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(icons[index]),
                                  height: 30,
                                ),
                                Text(
                                  items[index],
                                  style: 
                                  TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ))
            ],
          )),
    );
  }
}
