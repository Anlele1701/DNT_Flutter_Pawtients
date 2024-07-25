import 'package:flutter/material.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:intl/intl.dart';

class BillDetail extends StatefulWidget {
  BillDetail({super.key, this.idHD});
  String? idHD;
  @override
  State<BillDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BillDetail> {
  String? khamBenh = "khám bệnh";
  final List<Map<String, dynamic>> keThuoc = [
    {
      "idThuoc": "1",
      "tenThuoc": "Panadol Extra",
      "soLuong": "1",
      "giaTien": 52000
    },
    {
      "idThuoc": "2",
      "tenThuoc": "Panadol Extra",
      "soLuong": "10",
      "giaTien": 152000
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xfff8f8f8),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 55),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text("Tên thú cưng: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("Chấu Đọ",
                                style: TextStyle(
                                  fontSize: 18,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text("Ngày khám: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("2:00 PM - 16/7/2024",
                                style: TextStyle(
                                  fontSize: 18,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: khamBenh != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Chẩn đoán: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                            color:Color(0xffffffff)),
                                        child: const Text(
                                          "Bị trầm cảm sau sinh",
                                          style: TextStyle(fontSize: 18),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Kê đơn thuốc: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffCCCCCC))),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: const EdgeInsets.all(16),
                                          child: SizedBox(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: keThuoc.length,
                                              itemBuilder: (context, index) {
                                                return itemThuoc(index);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        const Text(
                          "Hình ảnh đính kèm: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: keThuoc.length,
                            itemBuilder: (context, index) {
                              return ImageItem();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Tổng tiền thanh toán: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Phí khám tại nhà",
                              style: TextStyle(fontSize: 18),
                            )),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: 'đ')
                                  .format(100000),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        khamBenh != null
                            ? Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Tiền kê đơn thuốc",
                                    style: TextStyle(fontSize: 18),
                                  )),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'vi_VN', symbol: 'đ')
                                        .format(52000),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        Container(
                          width: 500,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff000000))),
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Thành tiền",
                              style: TextStyle(fontSize: 30),
                            )),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: 'đ')
                                  .format(152000),
                              style: const TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "CT001",
                  style: TextStyle(fontSize: 35),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemThuoc(index) {
    final item = keThuoc[index];
    return Row(
      children: [
        SizedBox(
            width: 170,
            child: Text(
              item["tenThuoc"],
              style: const TextStyle(
                  fontSize: 18, overflow: TextOverflow.ellipsis),
            )),
        Expanded(
            child: Text(
          "x${item["soLuong"]}",
          style: const TextStyle(fontSize: 18),
        )),
        Text(
          NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
              .format(item["giaTien"]),
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  ImageItem() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xff000000))),
      margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
      width: 120,
      height: 120,
      child: Image.asset("images/cat_rect.png", fit: BoxFit.cover,),
    );
  }
}
