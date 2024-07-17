import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/drug.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';

class DrugService{
  String? api;
  Future<String?> getApi() async{
    return await ApiUrls().getIpAddress();
  }
  Future<Drug?> createNewDrug(Drug drug, ImagePet image) async{
    final dio=Dio();
    try{
      api= await getApi();
      FormData formData=FormData.fromMap({
        'drug':drug.toJson(),
        'hinhAnh':MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: MediaType.parse(image.mimetype),
        ),
      });
      Response response= await dio.post(api! + '/drug/create-new-drug', data: formData);
    }catch(e){
      print(e);
      return null;
    }
  }
}