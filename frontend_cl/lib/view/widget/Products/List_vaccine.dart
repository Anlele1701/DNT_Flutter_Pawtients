import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'content_filter.dart';
import 'package:chips_choice/chips_choice.dart';

class VaccinePro extends StatefulWidget {
  const VaccinePro({super.key});
  @override
  State<VaccinePro> createState() => VaccineProState();
}

class VaccineProState extends State<VaccinePro> {
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vaccine sử dụng gần đây nhất",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0.5,
                          blurRadius: 15,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vaccine ngừa dại chó mèo Biorabies",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text("300.000 Đ"),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Center(
                              child: Image.asset(
                            "assets/images/productest.png",
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                Row()
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChipsChoice<int>.single(
                value: tag,
                onChanged: (val) => setState(() => {
                      tag = val,
                    }),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: options2,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                choiceBuilder: (item, i) {
                  return CustomChip(
                      label: item.label,
                      selected: item.selected,
                      onSelect: item.select!);
                },
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
