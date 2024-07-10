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
        'http://192.168.1.100:3000/pet/create-new-pet',
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
}