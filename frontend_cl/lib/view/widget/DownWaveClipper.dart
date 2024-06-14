import 'dart:ui';

import 'package:flutter/material.dart';

class DownWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    debugPrint(size.width.toString());
    var path = Path();
    path.moveTo(0, 280);
    path.quadraticBezierTo(w / 2.5 + 25, 205, w / 2 + 25, 225);
    path.quadraticBezierTo(w / 1.5 + 125, 125, w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
