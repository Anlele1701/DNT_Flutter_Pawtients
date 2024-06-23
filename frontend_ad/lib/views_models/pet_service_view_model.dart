import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/pet_s_service.dart';
import 'package:frontend_ad/models/pet_service.dart';

class PetServiceViewModel extends ChangeNotifier{
  void createNewPetService(PetService petService) async{
    var newPetService=await Pet_S_Service().createNewPetService(petService);
    notifyListeners();
  }
}