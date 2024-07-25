import 'package:dio/dio.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/services/api_services.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  final dio = Dio();
  Future<User?> updateUser(User user, ImagePet image) async {
    try {
      FormData formData = FormData.fromMap({
        'hoTen': user.hoTen,
        'email': user.email,
        'sdt': user.sdt,
        'hinhAnh': MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: MediaType.parse(image.mimetype),
        ),
      });
      Response response = await dio.patch(
        '$devUserUpdate/${user.id}',
        data: formData,
      );
      return User.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
