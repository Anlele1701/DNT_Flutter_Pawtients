import 'package:flutter/material.dart';
import 'package:frontend/view/layout_screen.dart';
import 'package:frontend/view/petprofile_screen.dart';
import 'package:frontend/view/widget/AddPetScreen/AddPetCircle.dart';
import 'package:frontend/view/widget/AddPetScreen/PetCircle.dart';
import 'package:frontend/view/widget/LoginScreen/UpperWaveClipper.dart';
import 'package:frontend/view/widget/LoginScreen/UpperWaveClipper.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xffF48B29),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PetProfileScreen()));
                    });
                  },
                  icon: const Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                    weight: 400,
                    opticalSize: 30,
                    size: 40,
                  ),
                ),
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
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text('Duy Ân',
                        style: TextStyle(
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
                        color: Color(0xffD5D5D5).withOpacity(0.25),
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
                        content: 'Lê Thanh Duy Ân',
                      ),
                      UserProfileInfo(
                        screenWidth: screenWidth,
                        title: 'Giới tính',
                        content: 'Nam',
                      ),
                      UserProfileInfo(
                        screenWidth: screenWidth,
                        title: 'Email',
                        content: 'lethanhduyan@gmail.com',
                      ),
                      UserProfileInfo(
                        screenWidth: screenWidth,
                        title: 'Số điện thoại',
                        content: '0901234567',
                      ),
                      UserProfileInfo(
                        screenWidth: screenWidth,
                        title: 'Địa chỉ',
                        content: '71/11 Nguyễn Trãi, phường Bến Thành, quận 1',
                      ),
                      UserProfileInfo(
                        screenWidth: screenWidth,
                        title: 'Hạng thành viên',
                        content: 'Bạc',
                      ),
                    ],
                  ),
                ),
                const Text('Hồ Sơ Thú Cưng'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffD5D5D5).withOpacity(0.25),
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
                      AddPetCircle(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
          SizedBox(width: screenWidth * 0.255, child: Text('$title:')),
          SizedBox(width: screenWidth * 0.1),
          SizedBox(
            width: screenWidth * 0.45,
            child: Text(
              '$content',
              style: TextStyle(fontSize: 14),
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],

      ),
    );
  }
}
