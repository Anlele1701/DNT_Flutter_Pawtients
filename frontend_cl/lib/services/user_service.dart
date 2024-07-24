import 'package:dio/dio.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/user_model.dart';
import 'package:frontend/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserService {
  updateUser(User user, ImagePet image) async {
    try {
      FormData formData = FormData.fromMap({
        'user': user.toJson(),
        'hinhAnh': MultipartFile.fromBytes(
          image.data,
          filename: image.filename,
          contentType: MediaType.parse(image.mimetype),
        ),
      });
      final response =
          await http.patch(Uri.parse(devUserUpdate), body: formData, headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      print(e);
    }
  }
}
