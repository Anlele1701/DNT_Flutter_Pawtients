import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/DownWaveClipper.dart';
import 'package:frontend/view/widget/UpperWaveClipper.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 8), vsync: this);
    //? Top Animation
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topRight),
          weight: 2),
    ]).animate(_controller);
    //? Bottom animation
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 2),
    ]).animate(_controller);
    _controller.repeat();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => ClipPath(
              clipper: UpperWaveClipper(),
              child: Container(
                height: 241,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: const [
                      Color(0xffFF810B),
                      Color(0xffFB6D48),
                    ],
                        begin: _topAlignmentAnimation.value,
                        end: _bottomAlignmentAnimation.value)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => ClipPath(
                clipper: DownWaveClipper(),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: const [
                        Color(0xffFF810B),
                        Color(0xffFB6D48),
                      ],
                          begin: _topAlignmentAnimation.value,
                          end: _bottomAlignmentAnimation.value)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 50,
            right: 50,
            child: GlassmorphicContainer(
              width: 350,
              height: 630,
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
                  stops: [
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
                  const TextFieldLogin(
                    labelInput: "Email",
                    iconInput: Icons.email_outlined,
                    textObscure: false,
                  ),
                  const SizedBox(
                    height: 30,
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: TextField(
                            obscureText: _obscured,
                            focusNode: textFieldFocusNode,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              isDense: true,
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xff000000).withOpacity(.5)),
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
                                      size: 24,
                                      color: const Color(0xff808080)),
                                ),
                              ),
                              border: InputBorder.none,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Quên mật khẩu?",
                    style: TextStyle(color: Color(0xff723700), fontSize: 12),
                  ),
                  FilledButton(onPressed: () {}, child: Text("Đăng nhập")),
                  const SizedBox(height: 15),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Bạn chưa có tài khoản?"),
                    Text("Đăng ký",
                        style:
                            TextStyle(color: Color(0xff723700), fontSize: 12))
                  ]),
                  const Text("Copyright © 2024 Pawtient")
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin(
      {super.key,
      required this.labelInput,
      required this.iconInput,
      required this.textObscure});
  final String labelInput;
  final IconData iconInput;
  final bool textObscure;

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 30),
          child: TextField(
              obscureText: widget.textObscure,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isDense: true,
                hintStyle:
                    TextStyle(color: const Color(0xff000000).withOpacity(.5)),
                hintText: widget.labelInput,
                icon: Icon(widget.iconInput,
                    color: const Color(0xff808080), size: 23),
                border: InputBorder.none,
              )),
        ),
      ),
    );
  }
}
