import 'package:flutter/material.dart';
import 'package:frontend_ad/views/items/customer_item.dart';
class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Customers> {
  final List<CustomerItem> items = List.generate(
    10,
    (index) => const CustomerItem(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 580,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                return const CustomerItem();
              },
              ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Color(0xffF48B29), shape: BoxShape.circle),
                child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.add, size: 40,),
                color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xffF8F8F8),
    );
  }
}