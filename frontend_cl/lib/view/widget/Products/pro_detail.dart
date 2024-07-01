import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/BottomNavBar.dart';
import 'package:frontend/view/widget/Products/content_filter.dart';
import 'package:frontend/view/widget/app_bar.dart';

class Prodetail extends StatefulWidget {
  const Prodetail({super.key});

  @override
  State<Prodetail> createState() => ProdetailState();
}

class ProdetailState extends State<Prodetail> {
  int banner_cur = 0;
  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < images.length; i++)
          Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            height: i == banner_cur ? 3 : 3,
            width: i == banner_cur ? 25 : 15,
            decoration: BoxDecoration(
              color: i == banner_cur ? Color(0xFFF6C953) : Colors.grey,
              shape: BoxShape.rectangle,
            ),
          )
      ],
    );
  }

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFFBE8B5),
                borderRadius: BorderRadius.circular(20)),
                height: 250,
                width: double.infinity,
            child: CarouselSlider(
              items: images
                  .map((e) => Container(
                        child: Image.asset(
                          e,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                autoPlay: true,
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
            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vaccine ngừa dại chó mèo Biorabies",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 70, 69, 69),
                        fontSize: 27),
                        ),
                Text("VC001 | Thương hiệu : Biorables"),
                Text("1,500,000 VND",style: TextStyle(fontSize: 25,color: Color(0xFFF09036),fontWeight: FontWeight.w500,),),
                Text("Mô tả sản phẩm",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 102, 101, 101),fontWeight: FontWeight.w500,)),
                Text("Thành phần",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 102, 101, 101),fontWeight: FontWeight.w500,)),
                Text("Nước, Etylen Glicol, Benzen, Alcohol, Sorbitol, Poloxamer, Sodium"),
                Text("Phòng bệnh",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 102, 101, 101),fontWeight: FontWeight.w500,)),
                Text("Dại cho chó mèo, khùng"),
                Text("Thông tin chung",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 102, 101, 101),fontWeight: FontWeight.w500,)),
                Text("Vaccine thì đọc thấy nó chia ra nhiều loại tùy thuộc vào loại thú cưng. có loại cho chó cho mèo, chia ra nhiều tác dụng như ngăn dại, viêm gan,..."),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
