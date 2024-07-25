import 'package:dio/dio.dart';
import 'package:frontend/model/vacxin_model.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/view/widget/utils/ToastNoti.dart';

class VacxinService{
  Future<List<Vacxin?>?> getVacxin(int skip, int limit) async {
    final dio= Dio();
    final response =
        await dio.get("${devUrl}/vacxin/get-vacxin-list", queryParameters: {'skip': skip, 'limit': limit});
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> rs = (response.data);
      List<Vacxin> vacxins = rs.map((item) => Vacxin.fromJson(item)).toList();
      return vacxins;
    } else {
      errorToast(
          'Không thể tải dữ liệu', 'Không hiển thị được dữ liệu của thuốc');
      return null;
    }
  }
}