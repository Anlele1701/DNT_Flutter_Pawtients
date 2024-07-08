import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/view/widget/LoginScreen/GradientAnimation.dart';
import 'package:frontend/view/widget/utils/LoadingIndicator.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class OTPVerfiyScreen extends StatefulWidget {
  const OTPVerfiyScreen({super.key, required this.email});
  final String email;
  @override
  State<OTPVerfiyScreen> createState() => _OTPVerfiyScreenState();
}

class _OTPVerfiyScreenState extends State<OTPVerfiyScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pin1 = TextEditingController();
    TextEditingController pin2 = TextEditingController();
    TextEditingController pin3 = TextEditingController();
    TextEditingController pin4 = TextEditingController();
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
                const Text("Kiểm tra Email của bạn",
                    style: TextStyle(
                        color: Color(0xff723700),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    "Chúng tôi đã gửi mã xác nhận đến email của bạn",
                    style: TextStyle(
                        color: Color(0xff6A6363),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PinCode(
                      pinController: pin1,
                    ),
                    PinCode(
                      pinController: pin2,
                    ),
                    PinCode(
                      pinController: pin3,
                    ),
                    PinCode(
                      pinController: pin4,
                    )
                  ],
                ),
                const SizedBox(height: 12),
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
                      String pinCode =
                          (pin1.text + pin2.text + pin3.text + pin4.text)
                              .trim();
                      AuthServicess().verifyOTP(widget.email, pinCode, context);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Color(0xffFF810B)),
                    ),
                    child: const Text("Gửi mã đăng nhập ",
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

class PinCode extends StatefulWidget {
  const PinCode({
    super.key,
    required this.pinController,
  });
  final TextEditingController pinController;
  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 64,
        width: 64,
        child: TextFormField(
          controller: widget.pinController,
          onChanged: (value) {
            setState(() {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            });
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    const BorderSide(color: Color(0xffD9D9D9), width: 2)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffFF810B), width: 3),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
        ));
  }
}
