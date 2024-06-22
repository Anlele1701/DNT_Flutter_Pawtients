import 'package:flutter/material.dart';

class CreatePetService extends StatefulWidget {
  const CreatePetService({super.key});

  @override
  State<CreatePetService> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreatePetService> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Tên dịch vụ",
              labelStyle: TextStyle(color: Colors.black)
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Mô tả",
              labelStyle: TextStyle(color: Colors.black)
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Giá tiền",
              labelStyle: TextStyle(color: Colors.black)
            ),
          )
        ],
      ),
    );
  }
}