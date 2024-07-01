import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/widget/BottomNavBar.dart';
import 'package:frontend/view/widget/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/view/widget/Dich_Vu/service_content.dart';

class SalonService extends StatefulWidget {
  const SalonService({super.key});

  @override
  State<SalonService> createState() => _SalonServiceState();
}

int banner_cur = 0;

class _SalonServiceState extends State<SalonService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            title: "",
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            CarouselSlider(
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
                viewportFraction: 0.73, // dòng này chỉnh kích thước hàng banner
                aspectRatio: 3, // dòng này chỉnh kích thước hình
                onPageChanged: (value, reason) {
                  setState(() {
                    banner_cur = value;
                  });
                },
              ),
            ),
            buildCarouselIndicator(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                children: [
                  Image.asset("assets/icons/health_and_beauty.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Dịch vụ cắt tỉa",
                      style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF8F6B51),
                      ))
                ],
              ),
            ),
            Row(children: containers),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/salon_body_3.png",
                      cacheHeight: 150,
                    ),
                    Text("Cắt móng",style: TextStyle(fontSize: 17),),
                  ],
                ),
              ),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color with some transparency
                      offset: Offset(0,0), // Offset the shadow slightly to the right and down
                      blurRadius: 5.0, // Blur the shadow for a softer effect
                      spreadRadius: 0.0, // Don't spread the shadow outwards
                    ),
                  ]),
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
          ]
                ),
        )
    );
  }
}

List<Widget> containers = pairUpLists(imagesbody, imagesbodytext).map((tuple) {
  final String image = tuple.item1;
  final String text = tuple.item2;
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            cacheHeight: 140,
          ),
          Text(text,style: TextStyle(fontSize: 17),),
        ],
      ),
    ),
    width: 200,
    height: 180,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey
              .withOpacity(0.5), // Shadow color with some transparency
          offset:
              Offset(0, 0), // Offset the shadow slightly to the right and down
          blurRadius: 5.0, // Blur the shadow for a softer effect
          spreadRadius: 0.0, // Don't spread the shadow outwards
        ),
      ],
    ), // Hiển thị hình ảnh
  );
}).toList();

//hàm này để tạo các nút dưới banner
buildCarouselIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int i = 0; i < images.length; i++)
        Container(
          margin: const EdgeInsets.all(5),
          height: i == banner_cur ? 3 : 3,
          width: i == banner_cur ? 25 : 15,
          decoration: BoxDecoration(
            color: i == banner_cur ? Color(0xFFF48B29) : Colors.grey,
            shape: BoxShape.rectangle,
          ),
        )
    ],
  );
}
