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
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 70, 20, 50),
      child: Stack(
        children: [
          SmoothPageIndicator(
            controller: pageController,
            axisDirection: Axis.horizontal,
            count: BoardingItem().items.length,
            effect: WormEffect(
                spacing: 10.0,
                radius: 2.0,
                dotWidth: 30,
                dotHeight: 6.0,
                paintStyle: PaintingStyle.fill,
                dotColor: Colors.grey,
                activeDotColor: Color(0xFFF48B29),
                ),
          ),
          PageView.builder(
            onPageChanged: (value) => setState(() {
              islastpage = controller.items.length - 1 == value;
            }),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.items[index].title,
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF48B29)),
                          ),
                          Text(controller.items[index].Description,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54)),
                        ],
                      ),
                    ),
                    Container(
                        height: 450,
                        alignment: Alignment.center,
                        child: Image.asset(
                          controller.items[index].image,
                        )),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 80,
            child: Row(
              children: [
                GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Color(0xFFF48B29),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: islastpage ? 380 : 180,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(islastpage ? "Bắt đầu ngay" : "Tiếp tục",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                          Icon(
                            Icons.double_arrow_outlined,
                            color: Colors.white,
                          )
                        ],
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
                islastpage? SizedBox.shrink(): SizedBox(
                  width: 320,
                  child: TextButton(
                    onPressed: () async {
                      final press = await SharedPreferences.getInstance();
                      press.setBool("onboarding", true);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Bỏ qua",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
