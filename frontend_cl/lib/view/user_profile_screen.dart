import 'package:flutter/material.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/AddPetScreen/AddPetCircle.dart';
import 'package:frontend/view/widget/AddPetScreen/PetCircle.dart';
import 'package:frontend/view/widget/LoginScreen/UpperWaveClipper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userID});
  final String userID;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String userID = '';
  String userName = '';
  String userEmail = '';
  String gender = '';
  String phone = '';
  String rank = '';
  String address = '';
  String formattedName = '';
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
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
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      children: [
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Tên người dùng',
                          content: userName,
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Giới tính',
                          content: 'Nam',
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Email',
                          content: userEmail,
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Số điện thoại',
                          content: phone,
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Địa chỉ',
                          content: address,
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Hạng thành viên',
                          content: rank,
                        ),
                      ],
                    ),
                  ),
                  const Text('Hồ Sơ Thú Cưng'),
                  Container(
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
                    child: const Row(
                      children: [
                        PetCircle(),
                        SizedBox(width: 24),
                        PetCircle(),
                        SizedBox(width: 24),
                        PetCircle(),
                        SizedBox(width: 24),
                        AddPetCircle(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
  });

  final double screenWidth;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: screenWidth * 0.3,
              child: Text(
                '$title:',
              )),
          SizedBox(width: screenWidth * 0.07),
          SizedBox(
            width: screenWidth * 0.45,
            child: Text(
              content == "null" ? "Chưa cập nhật " : content,
              style: const TextStyle(fontSize: 14),
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
