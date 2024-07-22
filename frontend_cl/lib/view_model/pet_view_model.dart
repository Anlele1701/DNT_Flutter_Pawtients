import 'package:flutter/material.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/services/pet_service.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';

class PetViewModel {
  Future<Pet?> createNewPet(
      Pet pet, ImagePet image, String? userID, BuildContext context) async {
    Pet? createPet = await PetService().createNewPet(pet, image, userID);
    if (createPet != null) {
      successToast("Tạo thành công");
      Navigator.pop(context);
      return createPet;
    } else {
      successToast("Tạo thất bại");
      return null;
    }
  }

  Future<List<Pet?>?> getPetList(String? userID) async {
    try {
      List<Pet?>? petList = await PetService().getPetList(userID);
      return petList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Pet?> getPet(String? idThuCung)async{
    try{
      Pet? pet= await PetService().getPet(idThuCung);
      return pet;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}
