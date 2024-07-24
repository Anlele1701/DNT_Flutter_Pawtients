import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/pet_services.dart';

class Pet_Services_Service {
  Future<PetService?> createNewPetService(PetService petService) async {
    final Dio dio = Dio();
    try {
      final data = petService.toJson();
      Response response = await dio.post(
        devURL + '/pet-service/create-new-pet-service',
        data: data,
      );
      print(response.data);
      return PetService.fromJson(response.data);
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<String?> getNameService(String? idService)async{
    try{
      final dio= Dio();
      Response response= await dio.get('${devURL}/pet-service/getNameService/${idService}');
      if(response.statusCode==200){
        return response.data;
      }
      else return '';
    }catch(e){
      print(e);
      return null;
    }
  }
}
