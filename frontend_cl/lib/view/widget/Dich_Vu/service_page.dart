import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/Dich_Vu/service_content.dart';
import 'package:frontend/view/widget/Layout/appbar_drawer.dart';

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
        appBar: AppbarDrawer(title: "Dịch vụ khám bệnh"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              ),
              // tạo ra một khung để chia ra các tab
              Container(
                  //* chỉnh độ dài của các tab tại đây vì đây là một tab dài cắt nhỏ
                  height: 70,
                  width: double.infinity,
                  child: ListView.builder(
                    //scroll theo chiều ngang
                    scrollDirection: Axis.horizontal,
                    //* physics thêm các hiệu ứng scroll như scroll có thể kéo dản khi hết content,
                    //* hoặc không cho scroll khi hết content
                    physics: const BouncingScrollPhysics(),
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
                          duration: const Duration(milliseconds: 300),
                          //margin này để tách các tab ra
                          margin: const EdgeInsets.all(5),
                          // width này để tạo chiều rộng tab
                          width: 140,
                          decoration: BoxDecoration(
                            gradient: count == index
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFF1B237),
                                      Color(0xFFFB7E09)
                                    ],
                                    stops: [0.12, 1],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : const LinearGradient(colors: [
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
                                  style: const TextStyle(
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
                margin: const EdgeInsets.only(top: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(icons[count]),
                        color: const Color(0xFFF48B29),
                        height: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        items[count],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF8F6B51),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Image(
                    image: AssetImage(
                      pictures[count],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    height: 150,
                    child: Text(
                      contents[count],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(35, 16, 0, 0),
                    child: Column(children: Advantages(count)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFFFF7B00)),
                        ),
                        child: const Row(
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
            ]),
          ),
        ));
  }
}
