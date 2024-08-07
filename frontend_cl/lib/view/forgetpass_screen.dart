import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:frontend/view/widget/utils/LoadingIndicator.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class ForgetpassScreen extends StatefulWidget {
  const ForgetpassScreen({super.key});

  @override
  State<ForgetpassScreen> createState() => _ForgetpassScreenState();
}

class _ForgetpassScreenState extends State<ForgetpassScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => LoadingState(),
      builder: (context, child) => Scaffold(
          body: LoadingContainer(
        child: GradientAnimation(
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
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
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
                  const Text("Quên mật khẩu",
                      style: TextStyle(
                          color: Color(0xff723700),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6A6363)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF5F5F5)),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Nhập email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen())),
                    child: const Text(
                      "Đăng nhập",
                      style: TextStyle(color: Color(0xff723700), fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: const Color(0xff000000).withOpacity(.25),
                              offset: const Offset(0, 4))
                        ]),
                    child: FilledButton(
                      onPressed: () {
                        AuthServicess()
                            .sendEmail(emailController.text, context);
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Color(0xffFF810B)),
                      ),
                      child: const Text("Gửi mã đăng nhập ",
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
                          style:
                              TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
