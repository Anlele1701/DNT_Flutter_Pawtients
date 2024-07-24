import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/view/widget/item_list_view.dart';
import 'package:frontend/view_model/appointment_view_model.dart';

void showAnimatedDialog(BuildContext context, String? userID) {
  late Future<List<Appointment?>?> listAppointment =
      AppointmentViewModel().getListAppointment(userID);

  showGeneralDialog(
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 650,
              child: Column(
                children: [
                  const Text(
                    "Lịch sử Đặt lịch",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: listAppointment,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            List<Appointment?>? list =
                                snapshot.data as List<Appointment?>?;
                            return ListView.builder(
                              itemCount: list!.length,
                              itemBuilder: (context, index) {
                                return ItemListView(appointment: list[index]);
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.cancel_outlined))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
