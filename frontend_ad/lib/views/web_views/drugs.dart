import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/views/web_views/create_drug.dart';

class Drugs extends StatefulWidget {
  const Drugs({super.key});

  @override
  State<Drugs> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Drugs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Color(0xffF48B29), shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> CreateDrug()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 40,
                ),
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
