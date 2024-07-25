import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/models/bill.dart';
import 'package:frontend_ad/views/bill_detail.dart';
import 'package:frontend_ad/views/bills.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchaseItem extends StatefulWidget {
  PurchaseItem({super.key, this.item});
  Bill? item;
  @override
  State<PurchaseItem> createState() => _PurchaseItemState();
}

class _PurchaseItemState extends State<PurchaseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30),
        height: 130,
        decoration: BoxDecoration(
            color: const Color(0xFFFffafa),
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 4, 140, 8),
                              Color.fromARGB(255, 0, 250, 129)
                            ],
                            stops: [
                              0.8,
                              0.2
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft)),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.item?.id}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                            "Ngày khám: ${DateFormat('dd/MM/yyyy').format(widget.item!.ngayKham!)}")
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BillDetail(
                                      idHD: widget.item!.id,
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    )),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng tiền: ",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
                      .format(widget.item?.tongTien),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ));
  }
}
