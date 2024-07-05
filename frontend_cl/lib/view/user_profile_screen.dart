import 'package:flutter/material.dart';
import 'package:frontend/view/layout_screen.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              color: Color(0xffF48B29),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LayoutScreen()));
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
            ClipPath(
              clipper: UpperWaveClipper(),
              child: Container(
                height: 200,
                color: Color(0xffF48B29),
              ),
            ),
            Text('User Profile Screen'),
          ],
        ),
      ),
    );
  }
}
