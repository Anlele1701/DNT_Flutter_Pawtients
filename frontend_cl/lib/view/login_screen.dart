import 'dart:ffi';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/forgetpass_screen.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/register_screen.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscured = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                margin: const EdgeInsets.only(top: 65, bottom: 55),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(130)),
                  child: Image(
                    image: AssetImage('assets/images/pawtient_logo.png'),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              TextFieldLogin(
                labelInput: "Email",
                iconInput: Icons.email_outlined,
                textObscure: false,
                username: username,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 274,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextField(
                      obscureText: _obscured,
                      controller: password,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(
                            color: const Color(0xff000000).withOpacity(.5),
                            fontSize: 14),
                        hintText: "Password",
                        icon: const Icon(Icons.lock_outlined,
                            color: Color(0xff808080), size: 23),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _toggleObscured,
                            child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 20,
                                color: const Color(0xff808080)),
                          ),
                        ),
                        border: InputBorder.none,
                      )),
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
                  onPressed: () async {
                    final response = await AuthServicess()
                        .login(username.text, password.text, context);
                  },
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Bạn chưa có tài khoản?",
                    style: TextStyle(color: Color(0xff474747), fontSize: 12)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: Text(" Đăng ký",
                      style: TextStyle(color: Color(0xff723700), fontSize: 12)),
                )
              ]),
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
      ),
    );
  }
}

class TextFieldLogin extends StatefulWidget {
  TextFieldLogin({
    super.key,
    required this.labelInput,
    required this.iconInput,
    required this.textObscure,
    required this.username,
  });
  final String labelInput;
  final IconData iconInput;
  final bool textObscure;
  final TextEditingController username;

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
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
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 30),
        child: TextField(
            controller: widget.username,
            obscureText: widget.textObscure,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintStyle: TextStyle(
                  color: const Color(0xff000000).withOpacity(.5), fontSize: 14),
              hintText: widget.labelInput,
              icon: Icon(widget.iconInput,
                  color: const Color(0xff808080), size: 23),
              border: InputBorder.none,
            )),
      ),
    );
  }
}
