import 'package:dio/dio.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/services/api_services.dart';

class AppointmentService {
  Future<Appointment?> createAppointment(Appointment appointment, String? userID) async {
    final dio = Dio();
    try {
      final data = appointment.toJson();
      Response response = await dio
          .post('${devUrl}/appointment/create-new-appointment', data: {"appointment":data, "userID": userID});
      if (response.statusCode==201) {
        print(response.data);
        Appointment newAppointment = Appointment.fromJson(response.data);
        return newAppointment;
      } else {
        print("error");
        return null;
      }
    } catch (e) {
      print("Error creating appointment: $e");
      return null;
    }
  }

  Future<List<Appointment?>?> getListAppointment(String? userID)async{
    final dio = Dio();
    try{
      List<Appointment?> listAppointment = [];
      Response response= await dio.get("${devUrl}/appointment/get-appointment-list/${userID}");
      List<dynamic> appointmentListJson = response.data;
        listAppointment = appointmentListJson.map((appointmentJson) => Appointment.fromJson(appointmentJson)).toList();
        return listAppointment;
    }
    catch(e){
      print(e);
      return null;
    }
  }
}
