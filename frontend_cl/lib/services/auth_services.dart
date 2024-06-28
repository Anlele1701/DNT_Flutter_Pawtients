import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthServicess {
  Future login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final url = Uri.parse(prodLogin);
      final body = jsonEncode({'email': email, 'password': password});
      final loadingState = Provider.of<LoadingState>(context, listen: false);
      loadingState.isLoading = true;
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      final data = jsonDecode(response.body);
      loadingState.isLoading = false;
      print(loadingState.isLoading);
      if (response.statusCode == 400) {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      } else if (data['success'] && response.statusCode == 201) {
        successToast("Đăng nhập thành công");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      }
      return response;
    } on Exception catch (e) {
      errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
    }
  }
}
