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

  Future<List<Vacxin?>?> searchVacxinList(String? search)async{
    try{
      final dio= Dio();
      List<Vacxin?> listVacxin=[];
      Response response= await dio.get('${devUrl}/vacxin/search-vacxin-list', queryParameters: {'skip': 0, 'limit': 10,'search':search});
      if(response.statusCode==200){
        List<dynamic> vacxinListJson=response.data;
        listVacxin=vacxinListJson.map((vacxinJson)=>Vacxin.fromJson(vacxinJson)).toList();
        return listVacxin;
      }
      else return null;
    }catch(e){
      print(e);
      return null;
    }
  }

}