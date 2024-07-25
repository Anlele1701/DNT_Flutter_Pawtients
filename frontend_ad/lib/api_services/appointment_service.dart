import 'package:dio/dio.dart';
import 'package:frontend_ad/api_services/api_urls.dart';
import 'package:frontend_ad/models/appointment.dart';

class AppointmentService {
  Future<List<Appointment?>?> getAppointmentList() async {
    try {
      final dio = Dio();
      Response response =
          await dio.get('${devURL}/appointment/get-appointment-list');
      if (response.statusCode == 200) {
        List<dynamic> listJson = response.data;
        return listJson.map((item) => Appointment.fromJson(item)).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Appointment?> updateStatus(
      String? trangThai, String? idLichKham, String? idNV) async {
    try {
      final dio = Dio();
      Response response = await dio.patch(
          '${devURL}/appointment/update-appointment-status',
          queryParameters: {
            'idLichKham': idLichKham,
            'idNV': idNV,
            'trangThai': trangThai
          });
      if (response.statusCode == 200) {
        return Appointment.fromJson(response.data);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> updateNoti(String? idLichKham)async{
    try{
      final dio=Dio();
      Response response= await dio.patch('${devURL}/appointment/update-noti/${idLichKham}');
      if(response.statusCode == 200){
        return true;
      }
      else return false;
    }catch(e){
      print(e);
      return false;
    }
  }
}
