import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/Dich_Vu/service_content.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePage();
}

class _ServicePage extends State<ServicePage> {
  List<String> items = getItems();
  List<String> icons = getIcons();
  List<String> pictures = getPicture();
  List<String> contents = getContent();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text(
                  "Dịch vụ khám bệnh",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              // tạo ra một khung để chia ra các tab
              SizedBox(
                  //* chỉnh độ dài của các tab tại đây vì đây là một tab dài cắt nhỏ
                  height: 70,
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
                          width: 140,
                          decoration: BoxDecoration(
                            gradient: count == index
                                ? LinearGradient(
                                    colors: [
                                      Color(0xFFF1B237),
                                      Color(0xFFFB7E09)
                                    ],
                                    stops: [0.12, 1],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : LinearGradient(colors: [
                                    Color(0xFFD7C7B7),
                                    Color(0xFFD7C7B7)
                                  ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(icons[index]),
                                  height: 30,
                                ),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
              //Content Body
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(icons[count]),
                        color: Color(0xFFF48B29),
                        height: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        items[count],
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF8F6B51),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image(
                    image: AssetImage(
                      pictures[count],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    height: 150,
                    child: Text(
                      contents[count],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 15, 45, 0),
                    child: Column(children: Advantages(count)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFFF7B00)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/icons/Paws_Button.png"),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Đặt lịch ngay",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: '1', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '2', icon: Icon(Icons.home))
        ],
      ),
    );
  }
}
