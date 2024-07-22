import 'package:dio/dio.dart';
import 'package:frontend/services/api_services.dart';

class PetServicesService{
  Future<String?> getNameService(String? idService)async{
    try{
      final dio=Dio();
      Response response= await dio.get("${devUrl}/pet-service/getNameService/${idService}");
      return response.data.toString();
    }
    catch(e){
      print(e);
      return null;
    }
  }
}