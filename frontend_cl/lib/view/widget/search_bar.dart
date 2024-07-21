import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDelegate extends SearchDelegate {
  List<String> test = [
    "Vaccine ngừa dại chó mèo Biorabies",
    "Vaccine ngừa dại chó mèo JKSADKAHDaaaaaaaaabbbbbbbbbbcccccccccccc",
    "Vaccine ngừa dại chó mèo fijweoifjw",
    "Thuốc skdajsdjkkasdiwoowiid",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> testres = [];
    for (var item in test) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
      ;
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return ListViewBuild(result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> testres = [];
    for (var item in test) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        testres.add(item);
      }
      ;
    }
    return ListView.builder(
      itemCount: testres.length,
      itemBuilder: (context, index) {
        var result = testres[index];
        return ListViewBuild(result);
      },
    );
  }
}

Widget ListViewBuild(var result) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 12, 8, 8),
    height: 250,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.1),
        boxShadow: [
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
                  boxShadow: [
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
              child: Image.asset("assets/images/productest.png"),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              height: 70,
              width: 190,
              child: Text(
                result,
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
                "Phòng bệnh : aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "1.300.000 VNĐ",
                style: TextStyle(
                    color: Color(0xFFF48B29),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {},
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
