import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/AddPetScreen/AddPetCircle.dart';
import 'package:frontend/view/widget/AddPetScreen/PetCircle.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/view/widget/appointment_history.dart';

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
            IntrinsicHeight(
              child: Row(children: [
                const Padding(
                    padding: EdgeInsets.all(10), child: AddPetCircle()),
                VerticalDivider(
                  color: const Color(0xffE2E2E2),
                  thickness: 1,
                  width: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 75,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(left: 13.0, right: 5),
                        child: PetCircle(),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Center(
              child: Stack(
                children: [
                  Container(
                      height: screenHeight * 0.65 - 76,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                          //   color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(blurRadius: 14, color: Colors.grey)
                          ])),
                  SizedBox(
                    height: screenHeight * 0.5,
                    width: screenWidth * 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: AssetImage('assets/images/cat.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              const Text(
                                "Mi Mi",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  PetInfoBox(
                                    screenWidth: screenWidth,
                                    labelInput: "Tuổi",
                                  ),
                                  PetInfoBox(
                                    screenWidth: screenWidth,
                                    labelInput: "Giới tính",
                                  ),
                                  PetInfoBox(
                                    screenWidth: screenWidth,
                                    labelInput: "Cân nặng",
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(blurRadius: 14, color: Colors.grey)
                      ]),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onTap: () {
                        showAnimatedDialog(context);
                      },
                      child: ListTile(
                        title: Text("Xem lịch sử đã khám"),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                        leading: const Icon(Icons.history),
                        dense: false,
                        visualDensity:
                            VisualDensity(horizontal: -2, vertical: -2),
                      ),

                              ),
                              Divider(
                                color: const Color(0xffE2E2E2),
                                indent: screenWidth * 0.075,
                                endIndent: screenWidth * 0.075,
                              ),
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text(
                                      "#ID_THUCUNG",
                                    ),
                                  ),
                                ],
                              ),
                              PetDetailInfo(
                                screenWidth: screenWidth,
                                iconInput: Icons.calendar_today_outlined,
                                labelInput: "Ngày sinh",
                              ),
                              PetDetailInfo(
                                  screenWidth: screenWidth,
                                  iconInput: Icons.pets,
                                  labelInput: "Giống loài"),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          )))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(blurRadius: 14, color: Colors.grey)
                  ]),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                    onTap: () {
                        showAnimatedDialog(context);
                      },
                  child: ListTile(
                    title: Text("Xem lịch sử đã khám"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                    leading: const Icon(Icons.history),
                    dense: false,
                    visualDensity: VisualDensity(horizontal: -2, vertical: -2),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class PetDetailInfo extends StatelessWidget {
  const PetDetailInfo({
    super.key,
    required this.screenWidth,
    required this.labelInput,
    required this.iconInput,
    this.valueInput,
  });

  final double screenWidth;
  final String labelInput;
  final IconData iconInput;
  final String? valueInput;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, top: 5, right: screenWidth * 0.075),
      child: Row(
        children: [
          Icon(
            iconInput,
            color: const Color(0xff697288),
            size: 21,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            labelInput,
          ),
          const Spacer(),
          Text(
            valueInput ?? "N/A",
            style: const TextStyle(
                color: Color(0xff233248), fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class PetInfoBox extends StatelessWidget {
  const PetInfoBox({
    super.key,
    required this.screenWidth,
    this.ageValue,
    required this.labelInput,
  });

  final double screenWidth;
  final String? ageValue;
  final String labelInput;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xffF48B29),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ageValue ?? "N/A",
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
          ),
          Text(labelInput,
              style:
                  TextStyle(color: Colors.white, fontSize: screenWidth * 0.035))
        ],
      ),
    );
  }
}
