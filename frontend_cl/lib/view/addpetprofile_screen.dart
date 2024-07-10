import 'dart:convert';
import 'dart:io';
import 'package:frontend/model/image_model.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPetProfileScreen extends StatefulWidget {
  const AddPetProfileScreen({super.key, this.userID=""});
  final String userID;
  @override
  State<AddPetProfileScreen> createState() => _AddPetProfileScreenState();
}

class _AddPetProfileScreenState extends State<AddPetProfileScreen> {
  String _animalType = "Chó";
  String _genderType = "BT";
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController datePickerController = TextEditingController();
  TextEditingController giongLoaiController=TextEditingController();
  TextEditingController canNangController=TextEditingController();
  Pet pet=Pet();
  ImagePet? hinhAnh;
  final PetViewModel petViewModel=PetViewModel();
  Future openImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final imageData = await _image!.readAsBytes();
      final mimeType=lookupMimeType(pickedFile.path);
      setState(() {
        hinhAnh=ImagePet(filename: path.basename(_image!.path), data: imageData, mimetype: mimeType!);
      });
    }
  }

  datePickFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(1990),
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Icon(Icons.arrow_back_ios_new),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 20, bottom: 20),
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
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Color(0xffF48B29),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 22, top: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldInput(
                                hintText: "Tên thú cưng",
                                textEditingController: nameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Loại thú cưng",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                        activeColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          "Chó",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        value: 'Chó',
                                        groupValue: _animalType,
                                        onChanged: (value) {
                                          setState(() {
                                            _animalType = value!;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                        activeColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text("Mèo",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        value: 'Mèo',
                                        groupValue: _animalType,
                                        onChanged: (value) {
                                          setState(() {
                                            _animalType = value!;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                              TextField(
                                onTap: () => datePickFunction(context: context),
                                controller: datePickerController,
                                readOnly: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  suffixStyle: TextStyle(color: Colors.white),
                                  labelText: "Ngày sinh",
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFieldInput(
                                hintText: "Giống loài",
                                textInputAction: TextInputAction.next,
                                textEditingController: giongLoaiController,
                              ),
                              const SizedBox(height: 20),
                              const Text("Giới tính",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                        activeColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          "Bé trai",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        value: 'BT',
                                        groupValue: _genderType,
                                        onChanged: (value) {
                                          setState(() {
                                            _genderType = value!;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: RadioListTile<String>(
                                        activeColor: Colors.white,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text("Bé gái",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        value: 'BG',
                                        groupValue: _genderType,
                                        onChanged: (value) {
                                          setState(() {
                                            _genderType = value!;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                              TextFieldInput(
                                hintText: "Cân nặng",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                textInputAction: TextInputAction.done,
                                textEditingController: canNangController,
                              ),
                              const SizedBox(height: 20),
                              Text("Hình ảnh",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              const SizedBox(height: 10),
                              Material(
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () => openImageGallery(),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: _image == null
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
                                                        color:
                                                            Color(0xff635C5C),
                                                        fontSize: 16))
                                              ],
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: screenWidth,
                                child: OutlinedButton(
                                    onPressed: ()async {
                                      pet.tenThuCung=nameController.text;
                                      pet.loaiThuCung=_animalType;
                                      pet.ngaySinh=DateFormat('dd/MM/yyyy').parse(datePickerController.text);
                                      pet.giongLoai=giongLoaiController.text;
                                      if(_genderType=='BT') pet.gioiTinh=true;
                                      else pet.gioiTinh=false;
                                      pet.canNang=canNangController.text;
                                      final result=await petViewModel.createNewPet(pet, hinhAnh!, widget.userID, context);
                                      if(result==null) print('null');
                                      else print('hello ${result.tenThuCung}');
                                    },
                                    style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    child: Text("Tạo hồ sơ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20))),
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintText,
    this.textEditingController,
    this.keyboardType,
    required this.textInputAction,
  });
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(color: Colors.white),
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.white),
        isDense: true,
        suffixText: hintText == "Cân nặng" ? "Kg" : "",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
