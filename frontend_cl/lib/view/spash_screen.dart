import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/view/layout_screen.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/widget/Boarding/boarding_screen.dart';
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
      final boarding = prefs.getBool("onboarding") ?? false;
      if (token == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => boarding ? LoginScreen():OnBoarding() ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LayoutScreen(
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
                image: AssetImage('assets/images/pawtient_logo.png'),
                height: 270,
                width: 270,
              ),
            ),
          ),
        ));
  }
}
