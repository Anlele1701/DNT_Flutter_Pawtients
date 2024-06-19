import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/AddPetCircle.dart';
import 'package:frontend/view/widget/PetCircle.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: const Color(0xffF2F2F2),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hồ sơ thú cưng",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                color: Colors.black,
                child: Row(children: [
                  Padding(padding: EdgeInsets.all(10), child: AddPetCircle()),
                  Expanded(
                    child: SizedBox(
                      height: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 5),
                          child: PetCircle(),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 511,
                      width: 313,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/cat.jpg')),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
