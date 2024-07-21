import 'package:flutter/material.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:frontend/view/widget/utils/LoadingIndicator.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  @override
  void initState() {
    super.initState();
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => LoadingState(),
      builder: (context, child) => Scaffold(
          body: LoadingContainer(
        child: GradientAnimation(
            child: GlassmorphicContainer(
          width: screenWidth,
          height: screenHeight,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 65, bottom: 40),
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(130)),
                    child: Image(
                      image: AssetImage('assets/images/pawtient_logo.png'),
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                const Text("Tạo mật khẩu mới",
                    style: TextStyle(
                        color: Color(0xff723700),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Mật khẩu mới",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6A6363)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF5F5F5).withOpacity(.9)),
                  child: TextField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: GestureDetector(
                            onTap: () {
                              togglePasswordVisibility();
                            },
                            child: Icon(
                                passwordVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 20,
                                color: const Color(0xff808080)),
                          ),
                        ),
                        hintText: "Nhập mật khẩu mới",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Xác nhận mật khẩu mới",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6A6363)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF5F5F5).withOpacity(.9)),
                  child: TextField(
                    obscureText: confirmPasswordVisible,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: "Nhập mật khẩu mới",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: GestureDetector(
                            onTap: () {
                              toggleConfirmPasswordVisibility();
                            },
                            child: Icon(
                                confirmPasswordVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 20,
                                color: const Color(0xff808080)),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 47,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: const Color(0xff000000).withOpacity(.25),
                            offset: const Offset(0, 4))
                      ]),
                  child: FilledButton(
                    onPressed: () {
                      AuthServicess().changePassword(
                          widget.email,
                          passwordController.text,
                          confirmPasswordController.text,
                          context);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Color(0xffFF810B)),
                    ),
                    child: const Text("Thay đổi mật khẩu",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: Align(
                      alignment: Alignment(0.05, 0.9),
                      child: Text(
                        "Copyright © 2024 Pawtient",
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                      )),
                )
              ],
            ),
          ),
        )),
      )),
    );
  }
}
