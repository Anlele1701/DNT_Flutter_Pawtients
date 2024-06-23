import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/pet_service.dart';

class Pet_S_Service{
  Future<PetService?> createNewPetService(PetService petService)async{
    final Dio dio= Dio();
    try {
      final data = petService.toJson();
      Response response = await dio.post(
        ApiUrls.PAWTIENT_URL+'/pet-service/create-new-pet-service',
        data: data,
      );
      print(response.data);
      return PetService.fromJson(response.data);
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}