import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/views/public_views/bottom_nav.dart';
import 'package:frontend_ad/views/state/loading_state.dart';
import 'package:frontend_ad/views/widget/ToastNoti.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final Dio dio = Dio();
  Future login(String tenTK, String matKhau, context) async {
    try {
      final loadingState = Provider.of<LoadingState>(context, listen: false);
      loadingState.isLoading = true;
      final body = jsonEncode({'tenTK': tenTK, 'matKhau': matKhau});
      final response = await dio.post(devLogin, data: body);
      if (response.data['success'] == true) {
        successToast("Đăng nhập thành công");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token']);
        String myToken = response.data['token'];
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNav(token: myToken)));
      } else {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      }
      loadingState.isLoading = false;
    } on Exception catch (e) {
      errorToast("Đăng nhập thất bại", "Lỗi server");
      print(e);
    }
  }

  Future getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(Uri.parse(devEmpAuth), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
