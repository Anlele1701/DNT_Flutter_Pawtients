import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key});

  @override
  State<AppointmentDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentDetail> {
  String? stateChoose = "Chưa xác nhận";
  final List<String> listState = ["Chưa xác nhận", "Đồng ý", "Hủy"];
  final String? tinhTrangBenh = "Khám bệnh";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 40,
                )),
            Container(
              decoration: BoxDecoration(color: Color(0xffffffff)),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff000000)),
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          "images/cat_rect.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tên thú cưng: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "Chấu Đọ",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Text(
                            "Đặt ngày:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "2:00 PM - 16/7/2024",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text("Dịch vụ khám: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      Text("Tỉa lông",
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Trạng thái: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border: Border.all(color: (Colors.grey)),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          value: stateChoose,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              stateChoose = newValue;
                            });
                          },
                          items: listState
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: tinhTrangBenh != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tình trạng bệnh: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  "Bé có dấu hiệu nôn mửa, biếng ăn, thường xuyên nổi cáu với mn xung quanh.",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Color(0xffF48B29),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Lưu trạng thái",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: const Color(0xff00A1E6),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Tạo hóa đơn",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
