import 'package:frontend_ad/api_services/pet_service.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/pet.dart';

class PetViewModel{
  Future<List<Pet?>?> getPetList(List<String?>? dsIdThuCung)async{
    try{
      return await PetService().getPetList(dsIdThuCung);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getHinhAnh(String? idThuCung)async{
    try{
      return await PetService().getHinhAnh(idThuCung);
    }catch(e){
      print(e);
      return {};
    }
  }
}