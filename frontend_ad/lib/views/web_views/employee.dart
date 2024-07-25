import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/employee.dart';

class EmployeeView extends StatefulWidget {
  EmployeeView({super.key, this.employee});
  Employee? employee;
  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(Icons.arrow_back,size: 40,),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        margin: EdgeInsets.only(top: 10),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.only(top: 50),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/cat.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text("${widget.employee?.hoten}",
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          )),
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
                  const Text('Thông Tin Nhân Viên'),
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
                          title: 'Tên tài khoản',
                          content: "${widget.employee?.hoten}",
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Số điện thoại',
                          content: '${widget.employee?.sdt}',
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Giới tính',
                          content: widget.employee?.gioiTinh==true? "Nam": "Nữ",
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Tên tài khoản',
                          content: "${widget.employee?.tenTK}",
                        ),
                        UserProfileInfo(
                          screenWidth: screenWidth,
                          title: 'Chức vụ',
                          content: "${widget.employee?.chucVu}",
                        ),
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
