import 'package:flutter/material.dart';
import 'package:frontend_ad/models/pet.dart';
import 'package:frontend_ad/views/items/pet_item.dart';
import 'package:frontend_ad/views_models/pet_view_model.dart';

class Pets extends StatefulWidget {
  Pets({super.key, this.dsIdThuCung});
  List<String?>? dsIdThuCung;
  @override
  State<Pets> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pets> {
  PetViewModel petViewModel = PetViewModel();
  Future<List<Pet?>?> getPetList() async {
    return await petViewModel.getPetList(widget.dsIdThuCung);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: FutureBuilder<List<Pet?>?>(
            future: getPetList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('Không có thú cưng nào'),
                );
              } else {
                final items = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    print(items.length);
                    return PetItem(pet: items[index]);
                  },
                  itemCount: items.length,
                );
              }
            }));
  }
}
