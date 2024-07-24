import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/view/widget/item_list_view.dart';
import 'package:frontend/view_model/appointment_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({super.key, this.userID});
  String? userID;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _currentDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  AppointmentViewModel appointmentViewModel = AppointmentViewModel();
  List<Appointment?>? listAppointment;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListAppointment();
  }

  Future<void> getListAppointment() async {
    final list = await appointmentViewModel.getListAppointment(widget.userID);
    setState(() {
      listAppointment = list;
      isLoading = true;
      print("${listAppointment?.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 5,
                      )
                    ]),
                child: TableCalendar(
                  focusedDay: _focusDay,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(fontSize: 20),
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      todayTextStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xffF48B29),
                        shape: BoxShape.circle,
                      )),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 60)),
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    setState(() {
                      _currentDay = selectedDay;
                      _focusDay = focusedDay;
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(_currentDay, day),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Lịch hẹn sắp tới",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 230,
                child: listAppointment == null
                    ? Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("Không có thú cưng nào!"),
                      )
                    : ListView.builder(
                        itemCount: listAppointment?.length,
                        itemBuilder: (context, index) {
                          return ItemListView(
                              appointment: listAppointment?[index]); // Access the pre-created ItemListView objects
                        },
                      ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
