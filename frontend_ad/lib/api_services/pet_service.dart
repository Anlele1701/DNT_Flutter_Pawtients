import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/pet.dart';

class PetService{
  Future<List<Pet?>?> getPetList(List<String?>? listIdThuCung)async{
    try{
      final dio=Dio();
      Response response= await dio.get("${devURL}/pet/get-pet-list-ad", queryParameters: {'dsIdThuCung': listIdThuCung});
      if(response.statusCode==200){
        List<dynamic> listJson=response.data;
        return listJson.map((item)=>Pet.fromJson(item)).toList();
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Map<String,dynamic>> getHinhAnh(String? idThuCung)async{
    try{
      final dio=Dio();
      Response response= await dio.get('${devURL}/pet/get-pet-image/${idThuCung}');
      if(response.statusCode==200){
        Map<String, dynamic> json= response.data;
        return json;
      }
      else return {};
    }catch(e){
      print(e);
      return {};
    }
  }
}