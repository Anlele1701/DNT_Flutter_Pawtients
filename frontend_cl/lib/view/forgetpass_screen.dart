import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ForgetpassScreen extends StatefulWidget {
  const ForgetpassScreen({super.key});

  @override
  State<ForgetpassScreen> createState() => _ForgetpassScreenState();
}

class _ForgetpassScreenState extends State<ForgetpassScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GradientAnimation(
      child: GlassmorphicContainer(
        width: screenWidth,
        height: screenHeight,
        borderRadius: 50,
        blur: 45,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.4),
              const Color(0xFFffffff).withOpacity(0.4),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.35),
            const Color((0xFFFFFFFF)).withOpacity(0.35),
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 65, bottom: 40),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(130)),
                child: Image(
                  image: AssetImage('assets/images/pawtient_logo.png'),
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text("Quên mật khẩu",
                style: TextStyle(
                    color: Color(0xff723700),
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Email"),
              ],
            ),
            SizedBox(
              height: 44,
              width: 274,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 14,
                        color: const Color(0xff000000).withOpacity(.25),
                        offset: const Offset(0, 0))
                  ],
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetpassScreen())),
              child: const Text(
                "Quên mật khẩu?",
                style: TextStyle(color: Color(0xff723700), fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 167,
              height: 47,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        color: const Color(0xff000000).withOpacity(.25),
                        offset: const Offset(0, 4))
                  ]),
              child: FilledButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xffFF810B)),
                ),
                child: const Text("Đăng nhập",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: Align(
                  alignment: Alignment(0.05, 0.9),
                  child: Text(
                    "Copyright © 2024 Pawtient",
                    style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
