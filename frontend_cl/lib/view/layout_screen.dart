import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/view/appointment_screen.dart';
import 'package:frontend/view/booking_screen.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/petprofile_screen.dart';
import 'package:frontend/view/user_profile_screen.dart';
import 'package:frontend/view/widget/Dich_Vu/service_page.dart';
import 'package:frontend/view/widget/Dich_Vu/service_salon.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/Products/List_products.dart';
import 'package:frontend/view/widget/Products/List_vaccine.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shimmer/shimmer.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, required this.token});
  final String token;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  User? user;
  late String userID;
  late String userName = '';
  late String userEmail = '';
  List<Widget> _pages = [];
  bool _isLoading = true;
  final List<String> _titles = [
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
    AuthServicess().getInfo(widget.token).then((val) {
      setState(() {
        userID = val['_id'].toString();
        userName = val['hoTen'].toString();
        userEmail = val['email'].toString();
        user = User.fromJson(val);
        _pages = [
          HomeScreen(
            userID: userID,
            userNameInput: userName,
          ),
          AppointmentScreen(userID: user?.id),
          BookingScreen(
            userID: user?.id,
          ),
          PetProfileScreen(
            userID: user?.id,
          ),
          UserProfileScreen(userID: user?.id)
        ];
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 4
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(60),
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
                        backgroundColor: const Color(0xff474747),
                        child: user?.image?.data != null
                            ? ClipOval(
                                child: Image.memory(
                                  user?.image?.data as Uint8List,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : CircleAvatar(
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDoKp0wum3Z8G1cQXa7j9UtFbpTYqG5YhUcg&s%27",
                                ),
                              )),
                    label: '')
              ],
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(
          userName: userName,
          userEmail: userEmail,
          isLoading: _isLoading,
          user: user),
    );
  }
}

class _buildDrawer extends StatelessWidget {
  const _buildDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.isLoading,
    this.user,
  });

  final String userName;
  final bool isLoading;
  final User? user;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF6F6F6),
      child: ListView(
        children: [
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    accountName: Container(
                      color: Colors.grey,
                      width: 100,
                      height: 20,
                    ),
                    accountEmail: Container(
                      color: Colors.grey,
                      width: 150,
                      height: 20,
                    ),
                  ),
                )
              : UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                        0,
                        0.5,
                        0.75,
                        0.88,
                        1
                      ],
                          colors: [
                        Color(0xffFF6200),
                        Color(0xffFD7F2C),
                        Color(0xffFD9346),
                        Color(0xffFDA766),
                        Color(0xffFDB777),
                      ])),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: user?.image?.data != null
                          ? ClipOval(
                              child: Image.memory(
                                user?.image?.data as Uint8List,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : CircleAvatar(
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDoKp0wum3Z8G1cQXa7j9UtFbpTYqG5YhUcg&s%27",
                              ),
                            ))
                  // : const CircleAvatar(
                  //     backgroundColor: Colors.transparent,
                  //   ),
                  ,
                  accountName: Text(userName),
                  accountEmail: Text(userEmail)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Symbols.category_rounded,
                          color: Color(0xff635C5C),
                          size: 18,
                        ),
                      ),
                      TextSpan(
                        text: " Danh mục",
                        style:
                            TextStyle(color: Color(0xff635C5C), fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                  margin: const EdgeInsets.symmetric(vertical: 16),
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
                  child: const Column(
                    children: [
                      DrawerItem(
                        icon: Icons.medical_services_outlined,
                        title: 'Khám bệnh',
                        link: ServicePage(),
                      ),
                      DrawerItem(
                        icon: Icons.vaccines_rounded,
                        title: 'Vaccine',
                        link: VaccinePro(),
                      ),
                      DrawerItem(
                        icon: Symbols.pill_rounded,
                        title: 'Thuốc',
                        link: Products(),
                      ),
                      DrawerItem(
                        icon: Symbols.health_and_beauty_rounded,
                        title: 'Cắt tỉa',
                        link: SalonService(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Symbols.info,
                          color: Color(0xff635C5C),
                          size: 20,
                        ),
                      ),
                      TextSpan(
                        text: " Về Pawtient",
                        style:
                            TextStyle(color: Color(0xff635C5C), fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
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
                  child: const Column(
                    children: [
                      DrawerItem(
                        svg: 'assets/icons/drawer_menu_icon/tiktok.svg',
                        title: 'TikTok',
                      ),
                      DrawerItem(
                        svg: 'assets/icons/drawer_menu_icon/facebook.svg',
                        title: 'Facebook',
                      ),
                      DrawerItem(
                        svg: 'assets/icons/drawer_menu_icon/instagram.svg',
                        title: 'Instagram',
                      ),
                      DrawerItem(
                        svg: 'assets/icons/drawer_menu_icon/policy.svg',
                        title: 'Điều khoản',
                      ),
                      DrawerItem(
                        svg: 'assets/icons/drawer_menu_icon/privacy.svg',
                        title: 'Riêng tư',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Symbols.warning,
                          color: Color(0xff635C5C),
                          size: 18,
                        ),
                      ),
                      TextSpan(
                        text: " Nguy hiểm",
                        style:
                            TextStyle(color: Color(0xff635C5C), fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
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
                      GestureDetector(
                        onTap: () {
                          AuthServicess().logout(context);
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(Symbols.logout,
                                  color: Color(0xff474747)),
                              const SizedBox(width: 10),
                              const Text("Đăng xuất"),
                              const Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  opticalSize: 30,
                                  color: Color(0xff474747),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const DrawerItem(
                        icon: Symbols.delete,
                        title: 'Xoá tài khoản',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key, this.icon, required this.title, this.link, this.svg});

  final IconData? icon;
  final String title;
  final String? svg;
  final Widget? link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        link == null
            ? null
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => link!));
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            icon != null
                ? Icon(icon, color: const Color(0xff474747))
                : SvgPicture.asset(svg!),
            const SizedBox(width: 10),
            Text(title),
            const Spacer(),
            Container(
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                opticalSize: 30,
                color: Color(0xff474747),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserProfileAppBar extends StatefulWidget {
  const UserProfileAppBar({super.key});

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Symbols.home_filled_rounded,
              color: Colors.white,
              weight: 400,
              opticalSize: 30,
              size: 40,
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                weight: 400,
                opticalSize: 30,
                size: 35,
              )),
        )
      ],
    );
  }
}
