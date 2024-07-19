import 'package:flutter/material.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/services/pet_service.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:provider/provider.dart';

class PetViewModel{
  Future<Pet?>createNewPet(Pet pet, ImagePet image, String userID, BuildContext context)async {
    //final loadingState = Provider.of<LoadingState>(context, listen: false);
    //loadingState.isLoading = true;
    Pet? createPet= await PetService().createNewPet(pet, image, userID);
    if(createPet!=null){
      //loadingState.isLoading = false;
      successToast("Tạo thành công");
      Navigator.pop(context);
      return createPet;
    }
    else{
      //loadingState.isLoading = false;
      successToast("Tạo thất bại");
      return null;
    }
  }
  Future<List<Pet?>?> getPetList(String userID)async{
    try{
      List<Pet?>? petList=await PetService().getPetList(userID);
      return petList;
    }catch(e){
      print(e);
      return [];
    }
  }
}