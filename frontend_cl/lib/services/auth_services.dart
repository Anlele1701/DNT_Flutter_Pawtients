import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/view/changepassword_screen.dart';
import 'package:frontend/view/login_screen.dart';
import 'package:frontend/view/layout_screen.dart';
import 'package:frontend/view/otpverify_screen.dart';
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
      final url = Uri.parse(devLogin);
      final body = jsonEncode({'email': email, 'password': password});
      final loadingState = Provider.of<LoadingState>(context, listen: false);
      loadingState.isLoading = true;
      final response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
      });
      final data = jsonDecode(response.body);
      loadingState.isLoading = false;
      if (response.statusCode == 400) {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      } else if (data['success'] && response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['token']);
        String myToken = data['token'];
        successToast("Đăng nhập thành công");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LayoutScreen(token: myToken)));
      } else {
        errorToast("Đăng nhập thất bại", "Sai tên đăng nhập hoặc mật khẩu");
      }
      return response;
    } on Exception catch (e) {
      errorToast("Đăng nhập thất bại", "Lỗi server");
      print(e);
    }
  }

  logout(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
    });
    successToast("Đăng xuất thành công");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  bool _validateInput(String password, String confirmedPassword) {
    if (password != confirmedPassword) {
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
      if (_validateInput(password, confirmPassword)) {
        final url = Uri.parse(devRegister);
        final body = jsonEncode({
          'hoTen': username,
          'email': email,
          'password': password,
          'sdt': phone,
        });
        final response = await http.post(url,
            body: body, headers: {'Content-Type': 'application/json'});
        final data = jsonDecode(response.body);
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
      } else {
        loadingState.isLoading = false;
        errorToast("Đăng ký thất bại", "Mật khẩu không khớp");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getInfo(token) async {
    final response = await http.get(Uri.parse(devUserInfo), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final data = jsonDecode(response.body);
    return data;
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // final userID = decodedToken['id'];
    // final response =
    //     await http.get(Uri.parse('$prodUserInfo/$userID'), headers: {
    //   'Content-Type': 'application/json',
    // });
    // final data = jsonDecode(response.body);
    // print(data);
    // return response;
  }

  getUserID(userID) async {
    final response =
        await http.get(Uri.parse('$prodUserInfo/$userID'), headers: {
      'Content-Type': 'application/json',
    });
    final data = jsonDecode(response.body);
    return data;
  }

  sendEmail(email, context) async {
    final loadingState = Provider.of<LoadingState>(context, listen: false);
    loadingState.isLoading = true;
    final body = jsonEncode({'email': email});
    final response =
        await http.post(Uri.parse(devSendEmail), body: body, headers: {
      'Content-Type': 'application/json',
    });
    loadingState.isLoading = false;
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      successToast("Gửi mã thành công");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPVerfiyScreen(email: email)));
    } else {
      errorToast("Gửi mã thất bại", "Email không tồn tại");
    }
    return data['success'];
  }

  verifyOTP(String email, String pincode, context) async {
    final loadingState = Provider.of<LoadingState>(context, listen: false);
    loadingState.isLoading = true;
    final body = jsonEncode({'email': email, 'pinCode': pincode});
    final response = await http.post(Uri.parse(devVerifyOTP),
        body: body, headers: {'Content-Type': 'application/json'});
    final data = jsonDecode(response.body);
    loadingState.isLoading = false;
    if ((pincode.length) < 4) {
      errorToast("Xác thực thất bại", "Mã OTP sai cú pháp");
    } else {
      if (data['success'] == true) {
        successToast(data['message']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangePasswordScreen(email: email)));
      } else {
        errorToast("Xác thực thất bại", "Mã OTP không hợp lệ");
      }
    }
    return data['success'];
  }

  changePassword(
      String email, String password, String confirmPassword, context) async {
    final loadingState = Provider.of<LoadingState>(context, listen: false);
    loadingState.isLoading = true;
    if (_validateInput(password, confirmPassword)) {
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.patch(Uri.parse(devUpdatePassword),
          body: body, headers: {'Content-Type': 'application/json'});
      loadingState.isLoading = false;
      final data = jsonDecode(response.body);
      successToast(data['message']);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      loadingState.isLoading = false;
      errorToast("Đổi mật khẩu thất bại", "Vui lòng kiểm tra lại mật khẩu");
    }
  }
}
