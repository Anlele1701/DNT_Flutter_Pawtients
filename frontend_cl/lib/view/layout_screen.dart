import 'package:flutter/material.dart';
import 'package:frontend/view/addpetprofile_screen.dart';
import 'package:frontend/view/appointment_screen.dart';
import 'package:frontend/view/booking_screen.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/petprofile_screen.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:material_symbols_icons/symbols.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [];
  List<String> _titles = [
    '',
    'Lịch hẹn',
    'Đặt lịch',
    'Hồ sơ thú cưng',
    'Trang cá nhân'
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const AppointmentScreen(),
      const BookingScreen(),
      const PetProfileScreen(),
      const AddPetProfileScreen()
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: MyAppBar(title: _titles[_selectedIndex])),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffD5D5D5),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 4,
                ),
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xffFFFFFF),
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              iconSize: 30,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              unselectedItemColor: const Color(0xffBFBFBF),
              selectedItemColor: const Color(0xffF48B29),
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(
                      Symbols.home,
                      weight: 400,
                      opticalSize: 30,
                    ),
                    label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.calendar_month_rounded,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Material(
                      shape: const CircleBorder(),
                      color: const Color(0xff474747),
                      clipBehavior: Clip.antiAlias,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        icon: const Icon(Symbols.pets_rounded),
                        color: _selectedIndex == 2
                            ? const Color(0xffF48B29)
                            : Colors.white,
                      ),
                    ),
                    label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Symbols.sound_detection_dog_barking,
                      weight: 400,
                      opticalSize: 30,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                            "https://randomuser.me/api/portraits/thumb/women/16.jpg"),
                      ),
                    ),
                    label: '')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
