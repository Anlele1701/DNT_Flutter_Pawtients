import 'package:dio/dio.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'dart:typed_data';

class PetService{
  Future<Pet?> createNewPet(Pet pet, ImagePet image, String userID)async{
    final Dio dio=Dio();
    try{
      FormData formData=FormData.fromMap({
        'pet':pet.toJson(),
        'hinhAnh':MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: DioMediaType.parse(image.mimetype),
        ),
        'userID':userID
      });
      Response response= await dio.post(
        'http://10.20.1.76:3000/pet/create-new-pet',
        data: formData
      );
      if (response.statusCode == 201) {
        Pet pet1 = Pet.fromJson(response.data);
        return pet1;
      } else {
        print('Failed to create pet. Status code: ${response.statusCode}');
        return null;
      }
    }
    catch(e){
      print(e);
    }
  }

  Future<List<Pet?>> getPetList(String userID)async{
    final dio=Dio();
    try{
      List<Pet?> listPet=[];
      Response response=await dio.get('http://10.20.1.76:3000/pet/get-pet-list', queryParameters: {'userID': userID});
      if(response.statusCode==200){
        List<dynamic> petListJson=response.data;
        listPet=petListJson.map((petJson)=>Pet.fromJson(petJson)).toList();
        return listPet;
      }
      else{
        throw Exception('Failed to load Pet');
      }
    }catch(e){
      print(e);
      return [];
    }
  }
}