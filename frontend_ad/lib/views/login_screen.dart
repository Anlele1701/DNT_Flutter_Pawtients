import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/auth_services.dart';
import 'package:frontend_ad/views/state/loading_state.dart';
import 'package:frontend_ad/views/widget/LoadingIndicator.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<LoadingState>(
      create: (_) => LoadingState(),
      builder: (context, child) => Scaffold(
          body: LoadingContainer(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xffF48B29),
                Color(0xffFBC687),
              ])),
          // color: const Color(0xffF48B29),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 55),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(130)),
                      child: Image(
                        image: AssetImage('images/pawtient_logo.png'),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  GlassmorphicContainer(
                    width: 330,
                    height: 290,
                    borderRadius: 50,
                    blur: 30,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.3),
                          const Color(0xFFFFFFFF).withOpacity(0.3),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Nhân viên",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3C3C3C)),
                          ),
                          const SizedBox(height: 15),
                          textFieldInput(
                              hintTextInput: "Tên đăng nhập",
                              iconInput: Icons.person,
                              textObscure: false,
                              visibility: false,
                              controller: _usernameController),
                          const SizedBox(height: 14),
                          textFieldInput(
                              hintTextInput: "Mật khẩu",
                              iconInput: Icons.password_outlined,
                              textObscure: _passwordVisible,
                              onToggleVisibility: (isVisible) =>
                                  setState(() => _passwordVisible = isVisible),
                              visibility: true,
                              controller: _passwordController),
                          const SizedBox(height: 20),
                          Container(
                            width: screenWidth,
                            height: 47,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: const Color(0xff000000)
                                          .withOpacity(.25),
                                      offset: const Offset(0, 4))
                                ]),
                            child: FilledButton(
                              onPressed: () {
                                AuthServices().login(_usernameController.text,
                                    _passwordController.text, context);
                              },
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Color(0xffFF810B)),
                              ),
                              child: const Text("Đăng nhập",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class textFieldInput extends StatefulWidget {
  textFieldInput({
    super.key,
    required this.hintTextInput,
    required this.iconInput,
    required this.textObscure,
    this.onToggleVisibility,
    required this.visibility,
    required this.controller,
  });
  final String hintTextInput;
  final IconData iconInput;
  final bool textObscure;
  Function(bool)? onToggleVisibility;
  final bool visibility;
  final TextEditingController controller;

  @override
  State<textFieldInput> createState() => _textFieldInputState();
}

class _textFieldInputState extends State<textFieldInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: TextField(
            obscureText: widget.textObscure,
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(widget.iconInput),
              hintText: widget.hintTextInput,
              hintStyle: TextStyle(
                  color: const Color(0xff000000).withOpacity(.5), fontSize: 14),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: widget.visibility
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          widget.onToggleVisibility!(!widget.textObscure);
                        }),
                        child: Icon(
                            !widget.textObscure
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 22,
                            color: const Color(0xff808080)),
                      ),
                    )
                  : null,
            ),
          ),
        ));
  }
}
