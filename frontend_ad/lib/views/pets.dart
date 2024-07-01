import 'package:flutter/material.dart';
import 'package:frontend_ad/views/items/pet_item.dart';

class Pets extends StatefulWidget {
  const Pets({super.key});

  @override
  State<Pets> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pets> {
  final List<PetItem> items = List.generate(
    10,
    (index) => const PetItem(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                return const PetItem();
              },
              ),
          );
  }
}