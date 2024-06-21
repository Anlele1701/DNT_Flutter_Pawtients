import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddPetProfileScreen extends StatefulWidget {
  const AddPetProfileScreen({super.key});

  @override
  State<AddPetProfileScreen> createState() => _AddPetProfileScreenState();
}

class _AddPetProfileScreenState extends State<AddPetProfileScreen> {
  String _animalType = "Chó";
  File? _image;
  final picker = ImagePicker();

  Future openImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      pickedFile != null ? _image = File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 16, top: 25),
                  child: Icon(Icons.arrow_back_ios_new),
                )),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 20, bottom: 35),
              child: Text(
                "Tạo hồ sơ mới",
                style: TextStyle(
                    color: Color(0xff474747),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                  //  height: screenHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Color(0xffF48B29),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 22, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldInput(hintText: "Tên thú cưng"),
                        const SizedBox(height: 16),
                        Text(
                          "Loại thú cưng",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        //! WIP
                        Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              title: Text("Chó"),
                              leading: Radio<String>(
                                  value: 'Chó',
                                  groupValue: _animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      _animalType = value!;
                                    });
                                  }),
                            )),
                            Expanded(
                                child: ListTile(
                              title: Text("Chó"),
                              leading: Radio<String>(
                                  value: 'Chó',
                                  groupValue: _animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      _animalType = value!;
                                    });
                                  }),
                            )),
                            Expanded(
                                child: ListTile(
                              title: Text("Chó"),
                              leading: Radio<String>(
                                  value: 'Chó',
                                  groupValue: _animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      _animalType = value!;
                                    });
                                  }),
                            )),
                            Expanded(
                                child: ListTile(
                              title: Text("Chó"),
                              leading: Radio<String>(
                                  value: 'Chó',
                                  groupValue: _animalType,
                                  onChanged: (value) {
                                    setState(() {
                                      _animalType = value!;
                                    });
                                  }),
                            )),
                          ],
                        ),
                        TextFieldInput(hintText: "Ngày sinh"),
                        TextFieldInput(hintText: "Cân nặng"),
                        Text("Hình ảnh",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        Material(
                            child: InkWell(
                          onTap: () => openImageGallery(),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: _image == null
                                ? const Icon(Icons.add_a_photo)
                                : Image.file(_image!),
                          ),
                        )),
                      ],
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }
}

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintText,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.white),
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
