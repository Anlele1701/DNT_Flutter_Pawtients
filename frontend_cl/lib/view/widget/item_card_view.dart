import 'package:flutter/material.dart';

class ItemCardView extends StatefulWidget {
  ItemCardView({super.key, this.title});
  String? title;
  @override
  State<ItemCardView> createState() => _ItemCardViewState();
}

class _ItemCardViewState extends State<ItemCardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 160,
      height: 190,
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
              child: Image.network(
                'https://hanvet.com.vn/uploads/S%E1%BA%A3n%20ph%E1%BA%A9m/v%E1%BA%AFc%20xin/Ch%C3%B3%20m%C3%A8o/Rabiva.png',
                height: 120,
              ),
            ),
            Text(
              widget.title ?? "Vaccine ngừa dại Rabiva",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '300.000đ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
