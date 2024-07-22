import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/services/appointment_service.dart';

class AppointmentViewModel{
  Future<Appointment?> createAppointment(Appointment appointment, String? userID)async{
    final result=await AppointmentService().createAppointment(appointment, userID);
    return result;
  }

  Future<List<Appointment?>?> getListAppointment(String? userID) async{
    final result=await AppointmentService().getListAppointment(userID);
    return result;
  }
}