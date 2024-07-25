import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/vacxin_model.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/view/widget/Layout/appbar_drawer.dart';
import 'package:frontend/view/widget/Products/pro_detail.dart';
import 'package:frontend/view_model/vacxin_view_model.dart';
import 'package:intl/intl.dart';
import 'content_filter.dart';
import 'package:chips_choice/chips_choice.dart';

class VaccinePro extends StatefulWidget {
  const VaccinePro({super.key});
  @override
  State<VaccinePro> createState() => VaccineProState();
}

class VaccineProState extends State<VaccinePro> {
  late Future<List<Vacxin?>?> lstVacxin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lstVacxin = VacxinViewModel().getVacxin(0, 8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarDrawer(
        title: "Vaccine",
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vaccine ngừa dại chó mèo Biorabies",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  "300.000 Đ",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            child: Center(
                                child: Image.asset(
                              "assets/images/productest.png",
                            )),
                          ),
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
                child: FutureBuilder(
                  future: lstVacxin,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else {
                      final List<Vacxin?>? vacxins =
                          snapshot.data as List<Vacxin?>?;
                      return GridView.builder(
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
                        itemCount: vacxins?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Prodetail(product: vacxins[index]!);
                              }));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Image.memory(
                                            vacxins![index]!.hinhAnh!.data)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 3),
                                            blurRadius: 14,
                                            blurStyle: BlurStyle.inner),
                                      ]),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                  child: Column(children: [
                                    Divider(
                                      thickness: .25,
                                    ),
                                    Text(
                                      "${vacxins[index]?.tenVacxin}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'vi_VN', symbol: 'đ')
                                              .format(vacxins[index]?.giaTien),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffFF7B00),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                )),
          ),
        ]),
      ),
    );
  }
}
