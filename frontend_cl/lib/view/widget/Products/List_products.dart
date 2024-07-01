import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'content_filter.dart';
import 'package:chips_choice/chips_choice.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => ProductsState();
}

class ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          title: "",
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      GradientColor(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showChips = !showChips;
                              isIconRotated = !isIconRotated;
                            });
                          },
                          child: AnimatedRotation(
                            child: Icon(Icons.filter_list),
                            turns: isIconRotated ? -0.25 : 0,
                            duration: Duration(milliseconds: 100),
                          ),
                          style: ButtonStyle(
                            iconSize: MaterialStatePropertyAll(28),
                            iconColor:
                                MaterialStatePropertyAll(Color(0xFFFFFFFF)),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Visibility(
                      visible: showChips,
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,
                      child: MyChips()),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //dòng này chỉnh số lượng item trên một dòng
                    crossAxisCount: 2,
                    //khoảng cách height của các item
                    mainAxisSpacing: 20,
                    //khoảng cách width của các item
                    crossAxisSpacing: 10,
                    //Dòng này chỉnh độ dài của các item
                    childAspectRatio: 0.65),
                // dòng này mốt truyền length của các item vào
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(26, 190, 182, 182),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                              child:
                                  Image.asset("assets/images/productest.png")),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F2F2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 7),
                              )
                            ]),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                        child: Column(children: [
                          Text(
                            "Vaccine ngừa dại chó mèo Biorabies",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "300.000 Đ",
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF7B00),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
