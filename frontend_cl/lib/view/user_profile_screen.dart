import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/AddPetScreen/AddPetCircle.dart';
import 'package:frontend/view/widget/AddPetScreen/PetCircle.dart';
import 'package:frontend/view/widget/LoginScreen/UpperWaveClipper.dart';
import 'package:frontend/view/widget/utils/NormalLoading.dart';
import 'package:frontend/view/widget/utils/image_helper.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:frontend/view_model/user_vm.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key, this.userID});
  String? userID;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEdit = false;
  File? _image;
  // String userID = '';
  // String userName = '';
  // String userEmail = '';
  // String gender = '';
  // String phone = '';
  // String rank = '';
  // String address = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ImagePet? hinhAnh;
  String formattedName = '';
  User? user;
  final PetViewModel petViewModel = PetViewModel();
  Future<List<Pet?>?>? petList;
  @override
  void initState() {
    super.initState();
    petList = fetchData();
    AuthServicess().getUserID(widget.userID).then((val) {
      setState(() {
        user = User.fromJson(val);
        hinhAnh = user!.image;
        String fullName = user!.hoTen.toString();
        List<String> nameParts = fullName.split(' ');
        List<String> lastTwoNames =
            nameParts.skip(nameParts.length - 2).take(2).toList();
        formattedName = lastTwoNames.join(' ');
      });
    });
  }

  Future<List<Pet?>?> fetchData() async {
    return petViewModel.getPetList(widget.userID);
  }

  Future openImageGallery() async {
    final files = await ImageHelper().pickImage();
    if (files.isNotEmpty) {
      final croppedFile = await ImageHelper().cropImage(file: files.first);
      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
          hinhAnh = ImagePet(
            data: _image!.readAsBytesSync(),
            filename: _image!.path.split('/').last,
            mimetype: 'image/jpeg',
          );
        });
      }
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      petList = fetchData();
      AuthServicess().getUserID(widget.userID).then((val) {
        setState(() {
          user = User.fromJson(val);
          String fullName = user!.hoTen.toString();
          List<String> nameParts = fullName.split(' ');
          List<String> lastTwoNames =
              nameParts.skip(nameParts.length - 2).take(2).toList();
          formattedName = lastTwoNames.join(' ');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF48B29),
        toolbarHeight: 25,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
            future: petList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: NormalLoadingIndicator());
              } else {
                List<Pet?>? petList = snapshot.data;
                nameController =
                    TextEditingController(text: user?.hoTen.toString());
                emailController =
                    TextEditingController(text: user?.email.toString());
                phoneController =
                    TextEditingController(text: user?.sdt.toString());
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          color: const Color(0xffF48B29),
                          alignment: Alignment.centerRight,
                          child: Visibility(
                            visible: !isEdit,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 24, 0),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isEdit = !isEdit;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    weight: 400,
                                    opticalSize: 30,
                                    size: 35,
                                  )),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: screenHeight * .3,
                            ),
                            ClipPath(
                              clipper: UpperWaveClipper(),
                              child: Container(
                                height: 150,
                                color: const Color(0xffF48B29),
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: CircleAvatar(
                                        radius: 100,
                                        foregroundImage: _image != null
                                            ? FileImage(_image!)
                                                as ImageProvider
                                            : Image.memory(
                                                user!.image?.data as Uint8List,
                                              ).image,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isEdit,
                                      child: Positioned(
                                        bottom: 0,
                                        right: 10,
                                        child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: const Color(0xffF48B29),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                openImageGallery();
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: Text(formattedName,
                                      style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Thông Tin Chung'),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xffD5D5D5)
                                          .withOpacity(0.25),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: const Offset(4, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UserProfileInfo(
                                        screenWidth: screenWidth,
                                        title: 'Tên người dùng',
                                        controller: nameController,
                                        content:
                                            user?.hoTen.toString() ?? 'N/A',
                                        isEdit: isEdit),
                                    UserProfileInfo(
                                        screenWidth: screenWidth,
                                        title: 'Email',
                                        content:
                                            user?.email.toString() ?? 'N/A',
                                        isEdit: isEdit),
                                    UserProfileInfo(
                                        screenWidth: screenWidth,
                                        title: 'Số điện thoại',
                                        content: user?.sdt.toString() ?? 'N/A',
                                        isEdit: isEdit),
                                    UserProfileInfo(
                                      screenWidth: screenWidth,
                                      title: 'Hạng thành viên',
                                      content: user?.hangThanhVien.toString() ??
                                          'N/A',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: !isEdit,
                                child: const Text('Hồ Sơ Thú Cưng'),
                              ),
                              Visibility(
                                visible: !isEdit,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xffD5D5D5)
                                            .withOpacity(0.25),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: const Offset(4, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      AddPetCircle(userID: widget.userID),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: petList == null ||
                                                petList.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'Chưa có thú cưng nào',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 75,
                                                child: ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: petList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 13,
                                                                right: 8),
                                                        child: PetCircle(
                                                          pet: petList[index],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isEdit,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                isEdit = !isEdit;
                                              });
                                            },
                                            style: ButtonStyle(
                                              side: WidgetStateProperty.all(
                                                const BorderSide(
                                                  color: Color(0xffF48B29),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Hủy',
                                              style: TextStyle(
                                                  color: Color(0xffF48B29)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: FilledButton(
                                            onPressed: () {
                                              setState(() {
                                                isEdit = !isEdit;
                                                print(hinhAnh);
                                                if (user != null &&
                                                    hinhAnh != null) {
                                                  user!.hoTen = nameController
                                                      .text
                                                      .trim();
                                                  user!.email = emailController
                                                      .text
                                                      .trim();
                                                  user!.sdt = phoneController
                                                      .text
                                                      .trim();
                                                  UserViewModel().updateUser(
                                                      user!, hinhAnh!);
                                                } else {
                                                  print(
                                                      'User or hinhAnh is null');
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      const Color(0xffF48B29)),
                                            ),
                                            child: const Text('Lưu'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.content,
    this.controller,
    this.isEdit,
  });

  final double screenWidth;
  final String title;
  final String content;
  final bool? isEdit;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: AlignmentDirectional.centerStart,
              width: screenWidth * 0.3,
              //height: 35,
              child: Text(
                '$title:',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )),
          SizedBox(width: screenWidth * 0.07),
          SizedBox(
            width: screenWidth * 0.45,
            child: isEdit ?? false
                ? Container(
                    height: 30,
                    alignment: AlignmentDirectional.centerStart,
                    child: TextFormField(
                      controller:
                          controller ?? TextEditingController(text: content),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 6)),
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                    ),
                  )
                : Container(
                    //height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      content == "null" ? "Chưa cập nhật " : content,
                      style: const TextStyle(fontSize: 15),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
