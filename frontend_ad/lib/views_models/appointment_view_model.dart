import 'package:frontend_ad/api_services/appointment_service.dart';
import 'package:frontend_ad/models/appointment.dart';

class AppointmentViewModel{
  Future<List<Appointment?>?> getAppointmentList()async{
    try{
      return await AppointmentService().getAppointmentList();
    }catch(e){
      print(e);
    }
  }

  Future<Appointment?> updateStatus(String? trangThai, String? idLichKham, String? idNV)async{
    try{
      return await AppointmentService().updateStatus(trangThai, idLichKham, idNV);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool?> updateNoti(String? idLichKham)async{
    return await AppointmentService().updateNoti(idLichKham);
  }
}