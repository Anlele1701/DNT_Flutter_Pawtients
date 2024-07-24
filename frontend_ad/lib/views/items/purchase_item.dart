import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/views/bills.dart';
import 'package:provider/provider.dart';

class PurchaseItem extends StatefulWidget {
  const PurchaseItem({super.key});
  @override
  State<PurchaseItem> createState() => _PurchaseItemState();
}

class _PurchaseItemState extends State<PurchaseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        height: 130,
        decoration: BoxDecoration(
          color: Color(0xFFFffafa),
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50  ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 4, 140, 8),
                      const Color.fromARGB(255, 0, 250, 129)],
                      stops: [0.8,0.2],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft                    
                      )) ,
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(flex: 8,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("KH001", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24),),
                    Text("Ngày khám : 16/7/2024")
                  ],
                )),
                Expanded(flex: 2,child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                )),
              ],
            ),
            Divider(thickness: 0.5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Text("Tổng tiền: ",style: TextStyle(fontSize: 17),),
                Text("1.000.000 VNĐ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
              ],
            )
          ],
        ));
  }
}
