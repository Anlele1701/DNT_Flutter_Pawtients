import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/appointment.dart';
import 'package:frontend_ad/models/bill.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/order.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:frontend_ad/views/widget/ToastNoti.dart';
import 'package:frontend_ad/views_models/bill_view_model.dart';
import 'package:frontend_ad/views_models/drug_view_model.dart';
import 'package:frontend_ad/views_models/pet_services_view_model.dart';
import 'package:frontend_ad/views_models/vacxin_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class CreateBill extends StatefulWidget {
  CreateBill({super.key, this.appointment});
  Appointment? appointment;

  @override
  State<CreateBill> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateBill> {
  TextEditingController chanDoanController = TextEditingController();
  BillViewModel billViewModel = BillViewModel();
  bool isLoading = true;
  TextEditingController _searchController = TextEditingController();
  int skip = 0;
  List<Order?>? order = [];
  List<dynamic>? dsSP = [];
  int? tongTien = 0;
  DrugViewModel drugViewModel = DrugViewModel();
  VacxinViewModel vacxinViewModel = VacxinViewModel();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imagePickerList = [];
  int? giaTienDichVu = 0;
  @override
  initState() {
    super.initState();
    getGiaTien();
  }

  void selectedImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imagePickerList.addAll(selectedImages);
    }
    setState(() {});
  }

  Future<void> findProduct(String timKiem) async {
    setState(() {
      isLoading = true;
      dsSP?.clear();
    });

    skip = 0;
    await findDrug(timKiem);
    await findVacxin(timKiem);

    setState(() {
      skip += 6;
      isLoading = false;
    });
  }

  Future<void> findDrug(String timKiem) async {
    List<Drug?>? listDrug =
        await drugViewModel.searchDrugList(skip, 6, timKiem);
    if (listDrug != null) {
      setState(() {
        dsSP?.addAll(listDrug);
      });
      print(dsSP?.length);
    }
  }

  Future<void> findVacxin(String timKiem) async {
    List<Vacxin?>? listVacxin =
        await vacxinViewModel.searchVacxinList(skip, 6, timKiem);
    if (listVacxin != null)
      setState(() {
        dsSP?.addAll(listVacxin);
      });
  }

  Future<void> getGiaTien() async {
    int? giaTien =
        await PetServiceViewModel().getPrice(widget.appointment?.loaiDichVu);
    print(giaTien);
    setState(() {
      giaTienDichVu = giaTien;
    });
  }

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
                          child: widget.appointment?.tenDichVu != null
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
                                      controller: chanDoanController,
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
                                                  itemCount: order?.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return itemThuoc(
                                                        order?[index]);
                                                  },
                                                ),
                                              ),
                                              OutlinedButton(
                                                  onPressed: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
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
                            Expanded(
                                child: Text(
                              "${widget.appointment?.tenDichVu}",
                              style: TextStyle(fontSize: 18),
                            )),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: 'đ')
                                  .format(giaTienDichVu),
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        widget.appointment?.tenDichVu != null
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
                                        .format(tongTien),
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
                              "Tổng tiền",
                              style: TextStyle(fontSize: 30),
                            )),
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: 'đ')
                                  .format(tongTien! + giaTienDichVu!),
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
                            onPressed: () async {
                              Bill bill = Bill();
                              bill.chanDoan = chanDoanController.text;
                              bill.keDonThuoc = order;
                              bill.phiDichVu = widget.appointment?.loaiDichVu;
                              bill.tongTien = tongTien;
                              bill.idLichKham = widget.appointment?.id;
                              List<ImagePet?>? listImage = [];
                              for (XFile file in imagePickerList) {
                                String fileName = file.name;
                                Uint8List fileData = await file.readAsBytes();
                                String? mimeType = lookupMimeType(fileName);
                                listImage.add(ImagePet(
                                    filename: fileName,
                                    data: fileData,
                                    mimetype: mimeType!));
                              }
                              final result= await billViewModel.createBill(bill, listImage);
                              if(result is Bill){
                                successToast('Tạo hóa đơn thành công');
                              }
                              else{
                                errorToast('Thấ bại','');
                              }
                            },
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

  Widget itemThuoc(Order? item) {
    return Row(
      children: [
        SizedBox(
            width: 150,
            child: Text(
              "${item?.tenThuoc}",
              style: const TextStyle(
                  fontSize: 18, overflow: TextOverflow.ellipsis),
            )),
        Expanded(
            child: Row(
          children: [
            IconButton(
                onPressed: () {
                  if (item?.soLuong == 1) {
                    setState(() {
                      order?.removeWhere((i) => i?.idThuoc == item?.idThuoc);
                      tongTien = billViewModel.TinhTongTien(order);
                    });
                  } else {
                    setState(() {
                      item?.soLuong = (item.soLuong ?? 0) - 1;
                      item?.thanhTien = billViewModel.TinhThanhTien(
                          item.soLuong, item.giaTien);
                      tongTien = billViewModel.TinhTongTien(order);
                    });
                  }
                },
                icon: Icon(Icons.remove)),
            Text(
              "${item?.soLuong}",
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    item?.soLuong = (item.soLuong ?? 0) + 1;
                    item?.thanhTien =
                        billViewModel.TinhThanhTien(item.soLuong, item.giaTien);
                    tongTien = billViewModel.TinhTongTien(order);
                  });
                },
                icon: Icon(Icons.add)),
          ],
        )),
        Text(
          NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
              .format(item?.thanhTien),
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
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 400,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Tìm kiếm', border: InputBorder.none),
                      controller: _searchController,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await findProduct(_searchController.text);
                      },
                      icon: Icon(Icons.search)),
                ],
              ),
            ),
            Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : dsSP!.isEmpty
                        ? Center(
                            child: Text('Không có sản phẩm nào'),
                          )
                        : ListView.builder(
                            itemCount: dsSP?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.memory(
                                          dsSP?[index].hinhAnh.data),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: dsSP?[index] is Drug
                                          ? Text("${dsSP?[index]?.tenThuoc}")
                                          : Text("${dsSP?[index]?.tenVacxin}"),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () {
                                              int? location = order?.indexWhere(
                                                  (item) =>
                                                      item!.idThuoc ==
                                                      dsSP?[index].id);
                                              if (location == -1) {
                                                setState(() {
                                                  if (dsSP?[index] is Drug) {
                                                    order?.add(Order(
                                                        idThuoc:
                                                            dsSP?[index].id,
                                                        tenThuoc: dsSP?[index]
                                                            .tenThuoc,
                                                        soLuong: 1,
                                                        giaTien: dsSP?[index]
                                                            .giaTien,
                                                        thanhTien: dsSP?[index]
                                                            .giaTien));
                                                  } else {
                                                    order?.add(Order(
                                                        idThuoc:
                                                            dsSP?[index].id,
                                                        tenThuoc: dsSP?[index]
                                                            .tenVacxin,
                                                        soLuong: 1,
                                                        giaTien: dsSP?[index]
                                                            .giaTien,
                                                        thanhTien: dsSP?[index]
                                                            .giaTien));
                                                  }
                                                });
                                              } else {
                                                setState(() {
                                                  order?[location!]?.soLuong =
                                                      (order?[location]
                                                                  ?.soLuong ??
                                                              0) +
                                                          1;
                                                  order?[location!]?.thanhTien =
                                                      billViewModel
                                                          .TinhThanhTien(
                                                              order?[location]
                                                                  ?.soLuong,
                                                              order?[location]
                                                                  ?.giaTien);
                                                });
                                              }
                                              setState(() {
                                                tongTien =
                                                    billViewModel.TinhTongTien(
                                                        order);
                                              });
                                            },
                                            icon: Icon(Icons.add)))
                                  ],
                                ),
                              );
                            },
                          ))
          ],
        ),
      ),
    );
  }
}
