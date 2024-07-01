import 'package:flutter/material.dart';

class GradientAnimation extends StatefulWidget {
  const GradientAnimation({super.key, required this.child});
  final Widget child;

  @override
  State<GradientAnimation> createState() => _GradientAnimationState();
}

class _GradientAnimationState extends State<GradientAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    //? Top Animation
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(_controller);
    //? Bottom animation
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: const [Color(0xffFF7B00), Color(0xffF9B26F)],
                  begin: _topAlignmentAnimation.value,
                  end: _bottomAlignmentAnimation.value)),
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.10,
              left: 23,
              right: 23,
              bottom: screenHeight * 0.05,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
