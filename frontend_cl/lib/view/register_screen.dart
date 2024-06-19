import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:glassmorphism/glassmorphism.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => SingleChildScrollView(
                child: Container(
                    width: screenWidth,
                    height: screenHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: const [
                          Color(0xffFF7B00),
                          Color(0xffF9B26F)
                        ],
                            begin: _topAlignmentAnimation.value,
                            end: _bottomAlignmentAnimation.value)),
                    child: Stack(
                      children: [
                        Positioned(
                          top: screenHeight * 0.12,
                          left: 23,
                          right: 23,
                          child: GlassmorphicContainer(
                            width: screenWidth,
                            height: screenHeight * 0.8,
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
                                  margin: const EdgeInsets.only(
                                      top: 25, bottom: 46),
                                  child: const ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(130)),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/pawtient_logo.png'),
                                      height: 130,
                                      width: 130,
                                    ),
                                  ),
                                ),
                                TextFieldRegis(
                                  labelInput: "Email",
                                  iconInput: Icons.email_outlined,
                                  textObscure: false,
                                  keyboardInput: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 24.75),
                                PasswordTF(
                                  keyboardInput: TextInputType.visiblePassword,
                                  labelInput: "Nhập lại mật khẩu",
                                  iconInput: Icons.lock_outlined,
                                  textObscure: _passwordVisible,
                                  onToggleVisibility: (isVisible) => setState(
                                      () => _passwordVisible = isVisible),
                                ),
                                const SizedBox(height: 24.75),
                                PasswordTF(
                                  keyboardInput: TextInputType.visiblePassword,
                                  labelInput: "Nhập lại mật khẩu",
                                  iconInput: Icons.password_outlined,
                                  textObscure: _confirmPasswordVisible,
                                  onToggleVisibility: (isVisible) => setState(
                                      () =>
                                          _confirmPasswordVisible = isVisible),
                                ),
                                const SizedBox(height: 24.75),
                                const TextFieldRegis(
                                  keyboardInput: TextInputType.name,
                                  labelInput: "Họ và tên",
                                  iconInput: Icons.person_outlined,
                                  textObscure: false,
                                ),
                                const SizedBox(height: 24.75),
                                const TextFieldRegis(
                                  keyboardInput: TextInputType.phone,
                                  labelInput: "Số điện thoại",
                                  iconInput: Icons.phone_outlined,
                                  textObscure: false,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 167,
                                  height: 47,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 4,
                                            color: const Color(0xff000000)
                                                .withOpacity(.25),
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: FilledButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Color(0xffFF810B)),
                                    ),
                                    child: const Text("Đăng ký",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Bạn đã có tài khoản?",
                                          style: TextStyle(
                                              color: Color(0xff474747),
                                              fontSize: 12)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(" Đăng nhập",
                                            style: TextStyle(
                                                color: Color(0xff723700),
                                                fontSize: 12)),
                                      )
                                    ]),
                                Expanded(
                                  child: Align(
                                      alignment: const Alignment(0.05, 0.95),
                                      child: Text(
                                        "Copyright © 2024 Pawtient",
                                        style: TextStyle(
                                            color: const Color(0xffFFFFFF)
                                                .withOpacity(.6),
                                            fontSize: 12),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              )),
    );
  }
}

class PasswordTF extends StatefulWidget {
  PasswordTF({
    super.key,
    required this.labelInput,
    required this.iconInput,
    required this.textObscure,
    required this.keyboardInput,
    required this.onToggleVisibility,
  });
  final String labelInput;
  final IconData iconInput;
  bool textObscure;
  final TextInputType keyboardInput;
  final Function(bool) onToggleVisibility; // Function to update visibility

  @override
  State<PasswordTF> createState() => _PasswordTFState();
}

class _PasswordTFState extends State<PasswordTF> {
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
          padding: const EdgeInsets.only(left: 14, right: 8),
          child: TextField(
              obscureText: widget.textObscure,
              keyboardType: widget.keyboardInput,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: TextStyle(
                    color: const Color(0xff000000).withOpacity(.5),
                    fontSize: 14),
                hintText: widget.labelInput,
                icon: Icon(widget.iconInput,
                    color: const Color(0xff808080), size: 23),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    widget.onToggleVisibility(!widget.textObscure);
                  }),
                  child: Icon(
                      !widget.textObscure
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: 24,
                      color: const Color(0xff808080)),
                ),
              )),
        ),
      ),
    );
  }
}

class TextFieldRegis extends StatelessWidget {
  const TextFieldRegis({
    super.key,
    required this.labelInput,
    required this.iconInput,
    required this.textObscure,
    required this.keyboardInput,
  });
  final String labelInput;
  final IconData iconInput;
  final bool textObscure;
  final TextInputType keyboardInput;

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
              obscureText: textObscure,
              keyboardType: keyboardInput,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: TextStyle(
                    color: const Color(0xff000000).withOpacity(.5),
                    fontSize: 14),
                hintText: labelInput,
                icon: Icon(iconInput, color: const Color(0xff808080), size: 23),
                border: InputBorder.none,
              )),
        ),
      ),
    );
  }
}
