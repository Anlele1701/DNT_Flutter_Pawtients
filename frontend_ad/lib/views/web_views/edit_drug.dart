import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/views_models/drug_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class EditDrug extends StatefulWidget {
  const EditDrug({super.key, required this.drugItem});
  final Drug? drugItem;
  @override
  State<EditDrug> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditDrug> {
  Drug? drug;
  TextEditingController? tenthuocController;
  TextEditingController? hangThuocController;
  TextEditingController? moTaController;
  TextEditingController? soLuongController;
  TextEditingController? giaTienController;
  TextEditingController? phongBenhController;
  File? _image;
  ImagePet? hinhAnh;
  final picker = ImagePicker();
  DrugViewModel drugViewModel = DrugViewModel();
  @override
  void initState() {
    super.initState();
    drug = widget.drugItem;
    tenthuocController = TextEditingController(text: "${drug?.tenThuoc}");
    hangThuocController = TextEditingController(text: "${drug?.hangThuoc}");
    moTaController = TextEditingController(text: "${drug?.moTa}");
    soLuongController = TextEditingController(text: "${drug?.soLuong}");
    giaTienController = TextEditingController(text: "${drug?.giaTien}");
    phongBenhController = TextEditingController(text: "${drug?.phongBenh}");
    hinhAnh = drug?.hinhAnh;
  }

  Future openImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final imageData = await _image!.readAsBytes();
      final mimeType = lookupMimeType(pickedFile.path);
      setState(() {
        hinhAnh = ImagePet(
            filename: path.basename(_image!.path),
            data: imageData,
            mimetype: mimeType!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  const Text(
                    "Cập nhật sản phẩm",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: tenthuocController,
                        decoration: const InputDecoration(
                            labelText: "Tên thuốc",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: hangThuocController,
                        decoration: const InputDecoration(
                            labelText: "Hãng thuốc",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: moTaController,
                        decoration: const InputDecoration(
                            labelText: "Mô tả",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: soLuongController,
                        decoration: const InputDecoration(
                            labelText: "Thành phần",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: phongBenhController,
                        decoration: const InputDecoration(
                            labelText: "Phòng bệnh",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: giaTienController,
                        decoration: const InputDecoration(
                            labelText: "Giá tiền",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hình ảnh: "),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () => openImageGallery(),
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: hinhAnh == null
                                      ? const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                size: 80,
                                                color: Color(0xff635C5C)),
                                            Text("Chọn ảnh",
                                                style: TextStyle(
                                                    color: Color(0xff635C5C),
                                                    fontSize: 16))
                                          ],
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.memory(
                                            hinhAnh!.data,
                                            fit: BoxFit.cover,
                                          )),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () async {
                        drug!.id = widget.drugItem?.id;
                        drug!.tenThuoc = tenthuocController!.text;
                        drug!.hangThuoc = hangThuocController!.text;
                        drug!.moTa = moTaController!.text;
                        drug!.soLuong = int.tryParse(soLuongController!.text);
                        drug!.giaTien = int.parse(giaTienController!.text);
                        drug!.phongBenh = phongBenhController!.text;
                        final result =
                            await drugViewModel.updateDrug(drug!, hinhAnh!);
                        if (result is Drug) {
                          Navigator.pop(context, result);
                        }
                      },
                      child: Text(
                        "Lưu",
                        style: TextStyle(fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
