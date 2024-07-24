import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/views/items/purchase_item.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Bills> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                child: Text(
                  "Hóa đơn",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Tìm kiếm", border: InputBorder.none),
                      // controller: searchController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    },
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 670,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 10,
              itemBuilder: (context, index) {
                return PurchaseItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
