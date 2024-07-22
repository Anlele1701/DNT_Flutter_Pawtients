import 'package:flutter/material.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/edit_profile_screen.dart';
import 'package:frontend/view/widget/AddPetScreen/AddPetCircle.dart';
import 'package:frontend/view/widget/AddPetScreen/PetCircle.dart';
import 'package:frontend/view/widget/LoginScreen/UpperWaveClipper.dart';
import 'package:frontend/view/widget/utils/NormalLoading.dart';
import 'package:frontend/view_model/pet_view_model.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userID});
  final String userID;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEdit = false;

  String userID = '';
  String userName = '';
  String userEmail = '';
  String gender = '';
  String phone = '';
  String rank = '';
  String address = '';
  String formattedName = '';
  final PetViewModel petViewModel = PetViewModel();
  Future<List<Pet?>?>? petList;
  @override
  void initState() {
    super.initState();
    AuthServicess().getUserID(widget.userID).then((val) {
      setState(() {
        userID = val['_id'].toString();
        userName = val['hoTen'].toString();
        userEmail = val['email'].toString();
        phone = val['sdt'].toString();
        gender = val['gioiTinh'].toString();
        address = val['diaChi'].toString();
        rank = val['hangThanhVien'].toString();
        String fullName = userName;
        List<String> nameParts = fullName.split(' ');
        List<String> lastTwoNames =
            nameParts.skip(nameParts.length - 2).take(2).toList();
        formattedName = lastTwoNames.join(' ');
        petList = fetchData();
      });
    });
  }

  Future<List<Pet?>?> fetchData() async {
    return petViewModel.getPetList(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffF48B29),
      //   actions: [
      //     Visibility(
      //       visible: !isEdit,
      //       child: Padding(
      //         padding: const EdgeInsets.fromLTRB(0, 16, 24, 0),
      //         child: IconButton(
      //             onPressed: () {
      //               setState(() {
      //                 isEdit = !isEdit;
      //               });
      //             },
      //             icon: const Icon(
      //               Icons.edit,
      //               color: Colors.white,
      //               weight: 400,
      //               opticalSize: 30,
      //               size: 35,
      //             )),
      //       ),
      //     ),
      //   ],
      // ),
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
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              weight: 400,
                              opticalSize: 30,
                              size: 35,
                            )),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.only(top: 50),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/cat.jpg'),
                              fit: BoxFit.cover,
                            ),
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
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xffF48B29),
                                ),
                                child: IconButton(
                                  onPressed: () {},
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
                              fontSize: 35, fontWeight: FontWeight.w700)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Tên người dùng',
                            content: userName,
                            isEdit: isEdit),
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Giới tính',
                            content: 'Nam',
                            isEdit: isEdit),
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Email',
                            content: userEmail,
                            isEdit: isEdit),
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Số điện thoại',
                            content: phone,
                            isEdit: isEdit),
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Địa chỉ',
                            content: address,
                            isEdit: isEdit),
                        UserProfileInfo(
                            screenWidth: screenWidth,
                            title: 'Hạng thành viên',
                            content: rank,
                            isEdit: isEdit),
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffD5D5D5).withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: const Offset(4, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          PetCircle(),
                          SizedBox(width: 24),
                          PetCircle(),
                          SizedBox(width: 24),
                          PetCircle(),
                          SizedBox(width: 24),
                          AddPetCircle(userID: widget.userID),
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
                                child: const Text(
                                  'Hủy',
                                  style: TextStyle(color: Color(0xffF48B29)),
                                ),
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    BorderSide(
                                      color: Color(0xffF48B29),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    isEdit = !isEdit;
                                  });
                                },
                                child: const Text('Lưu'),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Color(0xffF48B29)),
                                ),
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
          );
        }
      },
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.content,
    required this.isEdit,
  });

  final double screenWidth;
  final String title;
  final String content;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: AlignmentDirectional.centerStart,
              width: screenWidth * 0.3,
              height: 35,
              child: Text(
                '$title:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )),
          SizedBox(width: screenWidth * 0.07),
          SizedBox(
            width: screenWidth * 0.45,
            child: isEdit
                ? Container(
                    height: 30,
                    alignment: AlignmentDirectional.centerStart,
                    child: TextFormField(
                      initialValue: content,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 6)),
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                    ),
                  )
                : Container(
                    height: 30,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      content == "null" ? "Chưa cập nhật " : content,
                      style: const TextStyle(fontSize: 15),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
            // Text(
            //   content == "null" ? "Chưa cập nhật " : content,
            //   style: const TextStyle(fontSize: 14),
            //   softWrap: true,
            //   maxLines: 2,
            // ),
          ),
        ],
      ),
    );
  }
}
