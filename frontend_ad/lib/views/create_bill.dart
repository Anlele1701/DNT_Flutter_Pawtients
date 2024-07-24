import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/appointment.dart';
import 'package:frontend_ad/models/order.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateBill extends StatefulWidget {
  CreateBill({super.key, this.appointment});
  Appointment? appointment;

  @override
  State<CreateBill> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateBill> {
  List<Order?>? order = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imagePickerList = [];
  void selectedImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imagePickerList.addAll(selectedImages);
    }
    setState(() {});
  }

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
                        Row(
                          children: [
                            Text("Tên thú cưng: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text("${widget.appointment?.tenThuCung}",
                                style: TextStyle(
                                  fontSize: 18,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text("Ngày khám: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text(
                                "${DateFormat('dd/MM/yyyy').format(widget.appointment!.ngayKham!)}",
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
                                    TextFormField(
                                      scrollPadding: const EdgeInsets.all(16),
                                      minLines: 1,
                                      maxLines: 10,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Viết chẩn đoán"),
                                    ),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: keThuoc.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return itemThuoc(index);
                                                  },
                                                ),
                                              ),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return chooseProduct();
                                                        });
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30),
                                                          side: const BorderSide(
                                                              color: Color(
                                                                  0xffB3B3B3))),
                                                  child: const Text(
                                                    "Thêm",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffB3B3B3),
                                                        fontSize: 18),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        const Row(
                          children: [
                            Text(
                              "Hình ảnh đính kèm: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Color(0xffFF0000)),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffCCCCCC))),
                          child: Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    side: const BorderSide(
                                        color: Color(0xffffffff))),
                                onPressed: () {
                                  selectedImages();
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Color(0xffC0C0C0),
                                      size: 40,
                                    ),
                                    Text(
                                      "Chọn ảnh",
                                      style: TextStyle(
                                          color: Color(0xffC0C0C0),
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                  width: 260,
                                  height: 120,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: imagePickerList.length,
                                      itemBuilder: (context, index) {
                                        return ImageItem(index);
                                      }))
                            ],
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                              color: const Color(0xffF48B29),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Xác nhận",
                              style: TextStyle(
                                  color: Color(0xffffffff), fontSize: 18),
                            ),
                          ),
                        )
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
                  "Kết quả khám bệnh",
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

  ImageItem(index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
            width: 100,
            height: 100,
            child: Image.file(
              File(imagePickerList[index].path),
              fit: BoxFit.cover,
            )),
        Positioned(
            top: 0,
            left: 85,
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: const Color(0xffD00000),
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      imagePickerList.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: const Color(0xffffffff),
                  iconSize: 10,
                ))),
      ],
    );
  }

  Widget chooseProduct() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 500,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(width: 100, child: Text("data")),
              Container(width: 100, child: Text("data")),
            ],
          ),
        ),
      ),
    );
  }
}
