import 'package:flutter/material.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({
    super.key,
    required this.textInput,
  });
  final String textInput;

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 56, 56, 56).withOpacity(0.25),
              offset: const Offset(1, 2),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xffFFC368)),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Image(
                  image: AssetImage('assets/images/catprofile.png'),
                  fit: BoxFit.contain,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.widget.textInput,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '9:00 - 20/7/2024',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Gâu Gâu - Bác sĩ Ngọc',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 30,
              opticalSize: 30,
              color: Color(0xff555555),
            ),
          )
        ],
      ),
    );
  }
}
