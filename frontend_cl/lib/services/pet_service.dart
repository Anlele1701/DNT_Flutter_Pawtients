import 'package:dio/dio.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'dart:typed_data';

import 'package:frontend/services/api_services.dart';

class PetService {
  Future<Pet?> createNewPet(Pet pet, ImagePet image, String? userID) async {
    final Dio dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        'pet': pet.toJson(),
        'hinhAnh': MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: DioMediaType.parse(image.mimetype),
        ),
        'userID': userID
      });
      Response response =
          await dio.post('${devUrl}/pet/create-new-pet', data: formData);
      if (response.statusCode == 201) {
        Pet pet1 = Pet.fromJson(response.data);
        return pet1;
      } else {
        print('Failed to create pet. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Pet?>> getPetList(String? userID) async {
    final dio = Dio();
    try {
      List<Pet?> listPet = [];
      Response response = await dio.get('${devUrl}/pet/get-pet-list',
          queryParameters: {'userID': userID});
      if (response.statusCode == 200) {
        List<dynamic> petListJson = response.data;
        listPet = petListJson.map((petJson) => Pet.fromJson(petJson)).toList();
        return listPet;
      } else {
        throw Exception('Failed to load Pet');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Pet?> getPet(String? idThuCung)async{
    try{
      final dio= Dio();
      Response response= await dio.get("${devUrl}/pet/get-pet/${idThuCung}");
      if(response.statusCode==200){
        Pet pet= Pet.fromJson(response.data);
        print(pet.tenThuCung);
        return pet;
      }
      else return null;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}
