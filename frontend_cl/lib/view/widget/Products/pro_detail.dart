import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/drug_model.dart';
import 'package:frontend/view/widget/Products/content_filter.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';

class Prodetail extends StatefulWidget {
  Prodetail({super.key, this.product});
  dynamic product;

  @override
  State<Prodetail> createState() => ProdetailState();
}

class ProdetailState extends State<Prodetail> {
  int banner_cur = 0;
  // buildCarouselIndicator() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       for (int i = 0; i < images.length; i++)
  //         Container(
  //           margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
  //           height: i == banner_cur ? 3 : 3,
  //           width: i == banner_cur ? 20 : 15,
  //           decoration: BoxDecoration(
  //             color: i == banner_cur ? Color(0xFFF6C953) : Colors.grey,
  //             shape: BoxShape.rectangle,
  //           ),
  //         )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          title: "",
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(20)),
              height: 250,
              width: double.infinity,
              child: Image(
                image: MemoryImage(widget.product.hinhAnh.data),
              )),
          Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.product is Drug ? widget.product.tenThuoc : widget.product.tenVacxin}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 70, 69, 69),
                      fontSize: 27),
                ),
                Text(
                    "Thương hiệu : ${widget.product is Drug ? widget.product.hangThuoc : widget.product.hangVacxin}"),
                Text(
                  "1,500,000 VND",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFF09036),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text("Mô tả sản phẩm",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontWeight: FontWeight.w500,
                    )),
                Text("Phòng bệnh",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontWeight: FontWeight.w500,
                    )),
                Text("${widget.product.phongBenh}"),
                Text("Thông tin chung",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontWeight: FontWeight.w500,
                    )),
                Text("${widget.product.moTa}"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
