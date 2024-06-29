import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:frontend/view/widget/utils/LoadingIndicator.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<LoadingState>(
        create: (_) => LoadingState(),
        builder: (context, child) => Scaffold(
                body: LoadingContainer(
              child: GradientAnimation(
                child: GlassmorphicContainer(
                  width: screenWidth,
                  height: screenHeight * 0.9,
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
                        margin: const EdgeInsets.only(top: 25, bottom: 46),
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(130)),
                          child: Image(
                            image:
                                AssetImage('assets/images/pawtient_logo.png'),
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
                        controller: email,
                      ),
                      const SizedBox(height: 24.75),
                      PasswordTF(
                        keyboardInput: TextInputType.visiblePassword,
                        labelInput: "Nhập mật khẩu",
                        iconInput: Icons.lock_outlined,
                        textObscure: _passwordVisible,
                        controller: password,
                        onToggleVisibility: (isVisible) =>
                            setState(() => _passwordVisible = isVisible),
                      ),
                      const SizedBox(height: 24.75),
                      PasswordTF(
                        keyboardInput: TextInputType.visiblePassword,
                        labelInput: "Nhập lại mật khẩu",
                        iconInput: Icons.password_outlined,
                        controller: confirmPassword,
                        textObscure: _confirmPasswordVisible,
                        onToggleVisibility: (isVisible) =>
                            setState(() => _confirmPasswordVisible = isVisible),
                      ),
                      const SizedBox(height: 24.75),
                      TextFieldRegis(
                        keyboardInput: TextInputType.name,
                        labelInput: "Họ và tên",
                        controller: name,
                        iconInput: Icons.person_outlined,
                        textObscure: false,
                      ),
                      const SizedBox(height: 24.75),
                      TextFieldRegis(
                        keyboardInput: TextInputType.phone,
                        labelInput: "Số điện thoại",
                        iconInput: Icons.phone_outlined,
                        textObscure: false,
                        controller: phone,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 167,
                        height: 47,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color:
                                      const Color(0xff000000).withOpacity(.25),
                                  offset: const Offset(0, 4))
                            ]),
                        child: FilledButton(
                          onPressed: () {
                            AuthServicess().register(
                                email.text,
                                password.text,
                                confirmPassword.text,
                                name.text,
                                phone.text,
                                context);
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
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
                                    color: Color(0xff474747), fontSize: 12)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(" Đăng nhập",
                                  style: TextStyle(
                                      color: Color(0xff723700), fontSize: 12)),
                            )
                          ]),
                      Expanded(
                        child: Align(
                            alignment: const Alignment(0.05, 0.95),
                            child: Text(
                              "Copyright © 2024 Pawtient",
                              style: TextStyle(
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(.6),
                                  fontSize: 12),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )));
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
    required this.controller,
  });
  final String labelInput;
  final IconData iconInput;
  bool textObscure;
  final TextInputType keyboardInput;
  final Function(bool) onToggleVisibility;
  final TextEditingController controller;

  @override
  State<PasswordTF> createState() => _PasswordTFState();
}

class _PasswordTFState extends State<PasswordTF> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              controller: widget.controller,
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
                      size: 23,
                      color: const Color(0xff808080)),
                ),
              )),
        ),
      ),
    );
  }
}

class TextFieldRegis extends StatefulWidget {
  const TextFieldRegis({
    super.key,
    required this.labelInput,
    required this.iconInput,
    required this.textObscure,
    required this.keyboardInput,
    required this.controller,
  });
  final String labelInput;
  final IconData iconInput;
  final bool textObscure;
  final TextInputType keyboardInput;
  final TextEditingController controller;

  @override
  State<TextFieldRegis> createState() => _TextFieldRegisState();
}

class _TextFieldRegisState extends State<TextFieldRegis> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              keyboardType: widget.keyboardInput,
              controller: widget.controller,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: TextStyle(
                    color: const Color(0xff000000).withOpacity(.5),
                    fontSize: 14),
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
