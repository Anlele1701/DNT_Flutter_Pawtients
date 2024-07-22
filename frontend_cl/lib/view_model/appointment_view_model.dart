import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/services/appointment_service.dart';

class AppointmentViewModel{
  Future<Appointment?> createAppointment(Appointment appointment)async{
    final result=await AppointmentService().createAppointment(appointment);
    return result;
  }
}