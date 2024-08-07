import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_ad/views/login_screen.dart';
import 'package:frontend_ad/views/public_views/bottom_nav.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNav(
                      token: token,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 207, 184),
        body: Center(
          child: WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
            atRestEffect: WidgetRestingEffects.bounce(),
            outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(130)),
              child: Image(
                image: AssetImage('images/pawtient_logo.png'),
                height: 270,
                width: 270,
              ),
            ),
          ),
        ));
  }
}
