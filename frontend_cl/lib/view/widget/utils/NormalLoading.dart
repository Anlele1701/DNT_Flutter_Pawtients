import 'dart:ui';

import 'package:flutter/material.dart';

class NormalLoadingIndicator extends StatelessWidget {
  const NormalLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Color(0xffF48B29),
                strokeWidth: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
