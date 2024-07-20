import 'package:flutter/material.dart';

class CustomTopSheet extends StatelessWidget {
  final Widget child;

  CustomTopSheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 300,
        width: 500,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        child: child,
      ),
    );
  }
}
