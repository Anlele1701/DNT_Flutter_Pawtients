import 'package:flutter/material.dart';
import 'package:frontend_ad/models/pet_service.dart';
import 'package:frontend_ad/views_models/pet_service_view_model.dart';
import 'package:provider/provider.dart';

class CreatePetService extends StatefulWidget {
  const CreatePetService({super.key});

  @override
  State<CreatePetService> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreatePetService> {
  final TextEditingController tenDichVuController=TextEditingController();
  final TextEditingController moTaController=TextEditingController();
  final TextEditingController giaTienController= TextEditingController();
  PetService petService= PetService();
  final PetServiceViewModel petServiceViewModel=PetServiceViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: tenDichVuController,
            decoration: const InputDecoration(
              labelText: "Tên dịch vụ",
              labelStyle: TextStyle(color: Colors.black)
            ),
          ),
          TextField(
            controller: moTaController,
            decoration: const InputDecoration(
              labelText: "Mô tả",
              labelStyle: TextStyle(color: Colors.black)
            ),
          ),
          TextField(
            controller: giaTienController,
            decoration: const InputDecoration(
              labelText: "Giá tiền",
              labelStyle: TextStyle(color: Colors.black)
            ),
          ),
          TextButton(onPressed: (){
            petService.tenDichVu=tenDichVuController.text;
            petService.moTa=moTaController.text;
            petService.giaTien=int.tryParse(giaTienController.text);
            petServiceViewModel.createNewPetService(petService);
            
          }, child: Text("Xác nhận"))
        ],
      ),
    );
  }
}