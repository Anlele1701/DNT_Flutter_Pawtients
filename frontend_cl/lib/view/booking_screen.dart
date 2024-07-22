import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view/widget/Layout/app_bar.dart';
import 'package:frontend/view_model/appointment_view_model.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key, this.userID});
  String? userID;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  AppointmentViewModel appointmentViewModel = AppointmentViewModel();
  Appointment? appointment = Appointment();
  List<Pet?>? petList = [];
  PetViewModel petViewModel = PetViewModel();
  static const List<String> petServiceList = <String>[
    'Khám tại nhà',
    'Khám tổng quát',
    'X-Quang',
    'Xét nghiệm',
    'Tiêm phòng'
  ];
  String dropdownValue = petServiceList.first;
  String? idPet;
  DateTime _currentDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    getPetList();
  }

  Future<void> getPetList() async {
    print(widget.userID);
    List<Pet?>? list = await petViewModel.getPetList(widget.userID);
    setState(() {
      petList = list;
      print("dasdas");
      print(petList?.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dịch vụ",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DropdownMenu<String>(
                    menuStyle: MenuStyle(),
                    hintText: "Chọn dịch vụ",
                    onSelected: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    dropdownMenuEntries: petServiceList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chọn thú cưng",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DropdownMenu<String>(
                    menuStyle: MenuStyle(),
                    hintText: "Chọn thú cưng",
                    onSelected: (String? value) {
                      setState(() {
                        idPet = value;
                      });
                    },
                    dropdownMenuEntries:
                        petList!.map<DropdownMenuEntry<String>>((Pet? value) {
                      return DropdownMenuEntry<String>(
                          value: value!.id!, label: value.tenThuCung!);
                    }).toList(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ]),
              child: FilledButton(
                  onPressed: () async {
                    DateTime dateTime = DateTime.parse(_currentDay.toString());
                    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                    String formattedDateString = dateFormat.format(dateTime);
                    appointment?.ngayKham =
                        DateFormat('dd/MM/yyyy').parse(formattedDateString);
                    appointment?.loaiDichVu = dropdownValue;
                    appointment?.idThuCung = idPet;
                    final result = await appointmentViewModel
                        .createAppointment(appointment!);
                    if (result is Appointment) {
                      print("success");
                    }
                  },
                  child: Text("Đặt lịch"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffF48B29)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
