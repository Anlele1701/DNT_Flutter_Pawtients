import 'package:flutter/material.dart';
import 'package:frontend/model/drug_model.dart';
import 'package:frontend/view/widget/Products/pro_detail.dart';
import 'dart:typed_data';

import 'package:intl/intl.dart';

class ItemCardView extends StatefulWidget {
  ItemCardView({
    super.key,
    this.drugModel,
  });

  dynamic drugModel;
  //Vaccine? vaccineModel;

  @override
  State<ItemCardView> createState() => _ItemCardViewState();
}

class _ItemCardViewState extends State<ItemCardView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Prodetail(product: widget.drugModel);
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: 160,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xffD5D5D5).withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: widget.drugModel?.hinhAnh?.data != null
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Image(
                          image: MemoryImage(
                              widget.drugModel?.hinhAnh!.data as Uint8List),
                          height: 120,
                        ),
                      )
                    : Container(),
              ),
              widget.drugModel is Drug
                  ? Text(
                      widget.drugModel?.tenThuoc ?? "N/A",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    )
                  : Text(
                      widget.drugModel?.tenVacxin ?? "N/A",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
              Text(
                widget.drugModel?.giaTien != null
                    ? NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                        .format(widget.drugModel?.giaTien)
                    : "N/A",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF48B29),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
