import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/views/public_views/appbar_drawer.dart';
import 'package:frontend_ad/views_models/drug_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class CreateDrug extends StatefulWidget {
  const CreateDrug({super.key});

  @override
  State<CreateDrug> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateDrug> {
  final TextEditingController tenThuocController = TextEditingController();
  final TextEditingController hangThuocController = TextEditingController();
  final TextEditingController moTaController = TextEditingController();
  final TextEditingController soLuongController = TextEditingController();
  final TextEditingController giaTienController = TextEditingController();
  final TextEditingController phongBenhController = TextEditingController();
  File? _image;
  ImagePet? hinhAnh;
  Drug drug = Drug();
  final drugViewModel = DrugViewModel();
  final picker = ImagePicker();
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
      appBar: const AppbarDrawer(
        title: "Thêm thuốc mới",
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
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
                        controller: tenThuocController,
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
                            labelText: "Số lượng",
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
                        drug.tenThuoc = tenThuocController.text;
                        drug.hangThuoc = hangThuocController.text;
                        drug.soLuong = int.tryParse(soLuongController.text);
                        drug.giaTien = int.tryParse(giaTienController.text);
                        drug.phongBenh = phongBenhController.text;
                        drug.moTa = moTaController.text;
                        final result =
                            await drugViewModel.createNewDrug(drug, hinhAnh!);
                        if (result is Drug) {
                          Navigator.pop(context, result);
                          print(result.tenThuoc);
                        } else
                          print("null");
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
