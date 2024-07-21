import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:frontend_ad/views_models/vacxin_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class CreateVacxin extends StatefulWidget {
  const CreateVacxin({super.key});

  @override
  State<CreateVacxin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateVacxin> {
  final TextEditingController tenVacxinController = TextEditingController();
  final TextEditingController quocGiaController = TextEditingController();
  final TextEditingController moTaController = TextEditingController();
  final TextEditingController thanhPhanController = TextEditingController();
  final TextEditingController giaTienController = TextEditingController();
  final TextEditingController phongBenhController = TextEditingController();
  final TextEditingController hangVacxinController = TextEditingController();
  File? _image;
  ImagePet? hinhAnh;
  Vacxin vacxin = Vacxin();
  final vacxinViewModel = VacxinViewModel();
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
                    "Thêm vacxin mới",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16),
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
                        controller: tenVacxinController,
                        decoration: const InputDecoration(
                            labelText: "Tên vacxin",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: hangVacxinController,
                        decoration: const InputDecoration(
                            labelText: "Hãng vacxin",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: quocGiaController,
                        decoration: const InputDecoration(
                            labelText: "Quốc gia",
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
                        controller: thanhPhanController,
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
                        vacxin.tenVacxin = tenVacxinController.text;
                        vacxin.quocGia = quocGiaController.text;
                        vacxin.thanhPhan = thanhPhanController.text;
                        vacxin.giaTien = int.tryParse(giaTienController.text);
                        vacxin.phongBenh = phongBenhController.text;
                        vacxin.moTa = moTaController.text;
                        vacxin.hangVacxin = hangVacxinController.text;
                        final result = await vacxinViewModel.createNewVacxin(
                            vacxin, hinhAnh!);
                        if (result is Vacxin) {
                          Navigator.pop(context, result);
                          print(result.tenVacxin);
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
