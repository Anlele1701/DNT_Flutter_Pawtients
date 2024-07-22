import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/model/drug_model.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';

class DrugService {
  final Dio dio = Dio();
  Future<List<Drug?>?> getDrugs(int skip, int limit) async {
    final response =
        await dio.get(devDrug, queryParameters: {'skip': skip, 'limit': limit});
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> rs = jsonDecode(response.data);
      List<Drug> drugs = rs.map((item) => Drug.fromJson(item)).toList();
      return drugs;
    } else {
      errorToast(
          'Không thể tải dữ liệu', 'Không hiển thị được dữ liệu của thuốc');
      return null;
    }
  }
}
