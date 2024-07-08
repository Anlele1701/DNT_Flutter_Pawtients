import 'package:flutter/material.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/services/pet_service.dart';

class PetViewModel extends ChangeNotifier{
  Future<Pet?>createNewPet(Pet pet, ImagePet image)async {
    return await PetService().createNewPet(pet, image);
  }
}