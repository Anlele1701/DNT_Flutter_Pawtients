import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/pet_services_service.dart';
import 'package:frontend_ad/models/pet_services.dart';

class PetServiceViewModel extends ChangeNotifier{
  void createNewPetService(PetService petService) async{
    var newPetService=await Pet_Services_Service().createNewPetService(petService);
    notifyListeners();
  }
  Future<String?> getNameService(String? idService)async{
    return await Pet_Services_Service().getNameService(idService);
  }
}