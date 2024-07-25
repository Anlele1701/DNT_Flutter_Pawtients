import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/drug_model.dart';
import 'package:frontend/model/vacxin_model.dart';
import 'package:frontend/view/widget/Products/pro_detail.dart';
import 'package:frontend/view_model/drug_view_model.dart';
import 'package:frontend/view_model/vacxin_view_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class CustomDelegate extends SearchDelegate {
  List<Drug?>? lstDrugs;
  List<Vacxin?>? lstVacxins;
  CustomDelegate({this.lstDrugs, this.lstVacxins});
  bool isLoading = false;
  List<String> test = [
    "Vaccine ngừa dại chó mèo Biorabies",
    "Vaccine ngừa dại chó mèo JKSADKAHDaaaaaaaaabbbbbbbbbbcccccccccccc",
    "Vaccine ngừa dại chó mèo fijweoifjw",
    "Thuốc skdajsdjkkasdiwoowiid",
  ];
  List<dynamic>? getResult() {
    List<dynamic>? lstResult = [];
    isLoading = true;
    if (lstDrugs != null) lstResult.addAll(lstDrugs!);
    if (lstVacxins != null) lstResult.addAll(lstVacxins!);
    return lstResult;
  }

  Future<List<Drug?>?> getDrugsList(String? search) async {
    return await DrugViewModel().searchDrugList(search);
  }

  Future<List<Vacxin?>?> getVacxinList(String? search) async {
    return await VacxinViewModel().searchVacxinList(search);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic>? results = getResult();
    print(results?.length);
    List<dynamic> testres = [];
    for (var item in results!) {
      String? tenSP = item is Drug ? item.tenThuoc : item.tenVacxin;
      if (tenSP!.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return ListViewBuild(result, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic>? results = getResult();
    print(results?.length);
    List<dynamic> testres = [];
    for (var item in results!) {
      String? tenSP = item is Drug ? item.tenThuoc : item.tenVacxin;
      if (tenSP!.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return ListViewBuild(result, context);
      },
    );
  }
}

Widget ListViewBuild(var result, BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(8, 12, 8, 8),
    height: 250,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0.5, 0.5),
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0, 0),
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(0.5, 0.5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 0),
                    )
                  ]),
              child: Image.memory(result.hinhAnh.data),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              height: 70,
              width: 190,
              child: Text(
                "${result is Drug ? result.tenThuoc : result.tenVacxin}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                maxLines:
                    2, // Adjust maxLines based on the desired number of visible lines
                overflow: TextOverflow
                    .ellipsis, // Display ellipsis when text overflows
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phòng bệnh : ${result.phongBenh}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(result.giaTien),
                style: TextStyle(
                    color: Color(0xFFF48B29),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Prodetail(product: result);
                  }));
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.1),
                        gradient: LinearGradient(
                          colors: [Color(0xFFF1B237), Color(0xFFFB7E09)],
                          stops: [0.12, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: Text(
                      "Xem chi tiết",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
