import 'dart:ui';

import 'package:flutter/material.dart';

class UpperWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(0, h - 50);
    path.quadraticBezierTo(150, h + 50, w - 40, h - 60);
    path.quadraticBezierTo(w - 40, h - 60, w, h - 80);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
