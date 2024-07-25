import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/drug_model.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/view/widget/Layout/appbar_drawer.dart';
import 'package:frontend/view/widget/Products/pro_detail.dart';
import 'package:frontend/view_model/drug_view_model.dart';
import 'package:intl/intl.dart';
import 'content_filter.dart';
import 'package:chips_choice/chips_choice.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => ProductsState();
}

class ProductsState extends State<Products> {
  late Future<List<Drug?>?> lstDrugs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lstDrugs = DrugViewModel().getDrugs(0, 8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarDrawer(
        title: "Thuốc",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                child: FutureBuilder(
                  future: lstDrugs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Đã xảy ra lỗi khi tải dữ liệu'),
                      );
                    } else {
                      List<Drug?>? drugs = snapshot.data;
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
                        itemCount: drugs?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Prodetail(product: drugs[index]);
                              }));
                            },
                            child: Column(
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
                                        child: Image.memory(
                                            drugs![index]!.hinhAnh!.data)),
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
                                            offset: Offset(0, 3),
                                            blurRadius: 14,
                                            blurStyle: BlurStyle.inner),
                                      ]),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 15),
                                  child: Column(children: [
                                    Text(
                                      "${drugs[index]?.tenThuoc}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'vi_VN', symbol: 'đ')
                                              .format(drugs[index]?.giaTien),
                                          style: TextStyle(fontSize: 18),
                                        ),
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
