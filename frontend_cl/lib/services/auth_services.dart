import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/layout_screen.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print(data);
      loadingState.isLoading = false;
      if (response.statusCode == 400) {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      } else if (data['success'] && response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String myToken = prefs.setString('token', data['token']).toString();
        successToast("Đăng nhập thành công");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LayoutScreen()));
      } else {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      }
      return response;
    } on Exception catch (e) {
      errorToast("Đăng nhập thất bại", "Lỗi server");
      print(e);
    }
  }

  bool _validateInput(String password, String confirmedPassword) {
    if (password != confirmedPassword) {
      errorToast("Đăng ký thất bại", "Mật khẩu không khớp");
      return false;
    }
    return true;
  }

  Future register(
    String email,
    String password,
    String confirmPassword,
    String username,
    String phone,
    BuildContext context,
  ) async {
    try {
      final loadingState = Provider.of<LoadingState>(context, listen: false);
      loadingState.isLoading = true;
      _validateInput(password, confirmPassword);
      final url = Uri.parse(devRegister);
      final body = jsonEncode({
        'hoTen': username,
        'email': email,
        'password': password,
        'sdt': phone,
      });
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      final data = jsonDecode(response.body);
      print(data);
      loadingState.isLoading = false;
      if (response.statusCode == 500) {
        errorToast("Lỗi server", "Tài khoản đã tồn tại");
      } else if (data['success']) {
        successToast("Đăng ký thành công");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        errorToast("Đăng ký thất bại", "Tài khoản đã tồn tại");
      }
      return response;
    } on Exception catch (e) {
      print(e);
    }
  }
}
