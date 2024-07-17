import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/auth_services.dart';
import 'package:frontend_ad/views/appointments.dart';
import 'package:frontend_ad/views/bills.dart';
import 'package:frontend_ad/views/customers.dart';
import 'package:frontend_ad/views/homepage.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.token});
  final String token;

  @override
  State<BottomNav> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNav> {
  int _currentIndex = 0;
  late String hoten;
  late String chucVu;
  List<Widget> body = const [HomePage(), Customers(), Appointments(), Bills()];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    AuthServices().getInfo().then((value) {
      setState(() {
        hoten = value['hoTen'];
        chucVu = value['chucVu'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'TRANG CHỦ',
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              label: 'KHÁCH HÀNG', icon: Icon(Icons.people)),
          BottomNavigationBarItem(
              label: 'LỊCH KHÁM', icon: Icon(Icons.calendar_month)),
          BottomNavigationBarItem(
            label: 'HÓA ĐƠN',
            icon: Icon(Icons.money),
          )
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xffF48B29),
        unselectedItemColor: const Color(0xff818181),
        onTap: _onItemTapped,
      ),
    );
  }
}
