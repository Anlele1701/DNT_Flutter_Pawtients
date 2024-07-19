import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/vacxin.dart';
import 'package:http_parser/http_parser.dart';

class VacxinService{
  Future<Vacxin?> createNewVacxin(Vacxin vacxin, ImagePet hinhAnh)async{
    final dio= Dio();
    try{
      FormData formData=FormData.fromMap({
        'vacxin': vacxin.toJson(),
        'hinhAnh': MultipartFile.fromBytes(hinhAnh.data, filename: hinhAnh.filename, contentType: MediaType.parse(hinhAnh.mimetype))
      });
      Response response= await dio.post('${devURL}/vacxin/create-new-vacxin', data: formData);
      return Vacxin.fromJson(response.data);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vacxin?>?> getVacxinList(int skip, int limit) async{
    try{
      final dio= Dio();
      List<Vacxin?> listVacxin=[];
      Response response= await dio.get('${devURL}/vacxin/get-vacxin-list', queryParameters: {'skip': skip, 'limit': limit});
      if(response.statusCode==200){
        List<dynamic> vacxinListJson=response.data;
        listVacxin=vacxinListJson.map((vacxinJson)=>Vacxin.fromJson(vacxinJson)).toList();
        return listVacxin;
      }
      else return null;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Vacxin?>?> searchVacxinList(int skip, int limit, String search) async{
    try{
      final dio= Dio();
      List<Vacxin?> listVacxin=[];
      Response response= await dio.get('${devURL}/vacxin/search-vacxin-list', queryParameters: {'skip': skip, 'limit': limit,'search':search});
      if(response.statusCode==200){
        List<dynamic> vacxinListJson=response.data;
        listVacxin=vacxinListJson.map((vacxinJson)=>Vacxin.fromJson(vacxinJson)).toList();
        return listVacxin;
      }
      else return null;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Vacxin?> updateVacxin(Vacxin vacxin, ImagePet hinhAnh)async{
    final dio= Dio();
    try{
      FormData formData=FormData.fromMap({
        'vacxin': vacxin.toJson(),
        'hinhAnh': MultipartFile.fromBytes(hinhAnh.data, filename: hinhAnh.filename, contentType: MediaType.parse(hinhAnh.mimetype))
      });
      Response response= await dio.patch('${devURL}/vacxin/update-vacxin', data: formData);
      return Vacxin.fromJson(response.data);
    }catch(e){
      print(e);
      return null;
    }
  }
}