import 'package:flutter/material.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/widget/Boarding/boarding_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  final controller = BoardingItem();
  final pageController = PageController();
  bool islastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet:Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30,0),
        margin: EdgeInsets.only(bottom: 80),
        color: Color.fromARGB(15, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              axisDirection: Axis.horizontal,
              count: BoardingItem().items.length,
              effect: ExpandingDotsEffect(
                spacing: 10.0,
                radius: 2.0,
                dotWidth: 12,
                dotHeight: 6,
                paintStyle: PaintingStyle.fill,
                dotColor: Colors.grey,
                activeDotColor: Color(0xFFF48B29),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: islastpage ?Color(0xFFF48B29) :Colors.black45, //0xFFF48B29
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 60,
                      height: 45,
                      child: Icon(
                        Icons.double_arrow_outlined,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      final press = await SharedPreferences.getInstance();
                      if (!islastpage)
                        pageController.nextPage(
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 300));
                      else {
                        press.setBool("onboarding", true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFF48B29),
            Color.fromARGB(15, 255, 255, 255)
          ],  
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops:[0.1,0.35]
          ),
        ),
        padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
        child: PageView.builder(
          onPageChanged: (value) => setState(() {
            islastpage = controller.items.length - 1 == value;
          }),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 280,
                    alignment: Alignment.center,
                    child: Image.asset(
                      controller.items[index].image,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Text(controller.items[index].Description,
                          style: TextStyle(fontSize: 17, color: Colors.black87,),
                          textAlign: TextAlign.center,),
                    ),
                    Center(
                      child: Text(
                        controller.items[index].title,
                        style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF48B29)),
                            textAlign: TextAlign.center
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
