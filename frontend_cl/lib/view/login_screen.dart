import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/DownWaveClipper.dart';
import 'package:frontend/view/widget/UpperWaveClipper.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          ClipPath(
            clipper: UpperWaveClipper(),
            child: Container(
              height: 241,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffFF810B), Color(0xffD3883B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: DownWaveClipper(),
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffFF810B), Color(0xffD3883B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
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
              borderRadius: 20,
              blur: 20,
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
              child: const Column(
                children: [Text("Trd ")],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
