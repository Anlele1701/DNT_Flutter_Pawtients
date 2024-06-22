import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      child: SafeArea(
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
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              iconSize: 30,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              backgroundColor: const Color(0xffFFFFFF),
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
