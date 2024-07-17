import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
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
  final TextEditingController thanhPhanController = TextEditingController();
  final TextEditingController giaTienController = TextEditingController();
  final TextEditingController phongBenhController = TextEditingController();
  File? _image;
  ImagePet? hinhAnh;
  Drug drug=Drug();
  final drugViewModel= DrugViewModel();
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
      body: Column(
        children: [
          TextField(
            controller: tenThuocController,
            decoration: const InputDecoration(
                labelText: "Tên thuốc",
                labelStyle: TextStyle(color: Colors.black)),
          ),
          TextField(
            controller: hangThuocController,
            decoration: const InputDecoration(
                labelText: "Hãng thuốc",
                labelStyle: TextStyle(color: Colors.black)),
          ),
          TextField(
            controller: moTaController,
            decoration: const InputDecoration(
                labelText: "Mô tả", labelStyle: TextStyle(color: Colors.black)),
          ),
          TextField(
            controller: thanhPhanController,
            decoration: const InputDecoration(
                labelText: "Thành phần",
                labelStyle: TextStyle(color: Colors.black)),
          ),
          TextField(
            controller: giaTienController,
            decoration: const InputDecoration(
                labelText: "Giá tiền",
                labelStyle: TextStyle(color: Colors.black)),
          ),
          TextField(
            controller: phongBenhController,
            decoration: const InputDecoration(
                labelText: "Phòng bệnh",
                labelStyle: TextStyle(color: Colors.black)),
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
                  child: _image == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined,
                                size: 80, color: Color(0xff635C5C)),
                            Text("Chọn ảnh",
                                style: TextStyle(
                                    color: Color(0xff635C5C), fontSize: 16))
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              )),
          TextButton(onPressed: () {
            drug.tenThuoc=tenThuocController.text;
            drug.hangThuoc=hangThuocController.text;
            drug.thanhPhan=thanhPhanController.text;
            drug.giaTien=int.tryParse(giaTienController.text);
            drug.phongBenh=phongBenhController.text;
            drug.moTa=moTaController.text;
            drugViewModel.createNewDrug(drug, hinhAnh!);
          }, child: Text("Xác nhận"))
        ],
      ),
    );
  }
}
