import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/services/api_services.dart';

class AuthServicess {
  Dio dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));
  login(String email, String password) async {
    try {
      return await dio.post(ApiUrls.CL_API_Authen + "login",
          data: {"email": email, "password": password},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
    } on DioException catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
