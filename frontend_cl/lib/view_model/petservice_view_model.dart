import 'package:frontend/services/pet_services_service.dart';

class PetserviceViewModel{
  Future<String?> getService(String? idService)async{
    try{
      return await PetServicesService().getNameService(idService);
    }catch(e){
      print(e);
      return null;
    }
  }
}