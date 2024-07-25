import 'package:flutter/material.dart';
import 'package:frontend_ad/models/appointment.dart';
import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/views/appointment_detail.dart';
import 'package:frontend_ad/views_models/pet_services_view_model.dart';
import 'package:frontend_ad/views_models/pet_view_model.dart';
import 'package:intl/intl.dart';

class AppointmentItem extends StatefulWidget {
  AppointmentItem({super.key, this.appointment});
  Appointment? appointment;
  @override
  State<AppointmentItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentItem> {
  PetViewModel petViewModel = PetViewModel();
  PetServiceViewModel petServiceViewModel = PetServiceViewModel();
  Future<ImagePet?> getHinhAnh() async {
    Map<String, dynamic> json =
        await petViewModel.getHinhAnh(widget.appointment?.idThuCung);
    if (json['hinhAnh'] != null)
      widget.appointment?.thuCung = ImagePet.fromjson(json['hinhAnh']);
    else
      widget.appointment?.thuCung = null;
    widget.appointment?.tenThuCung = json['tenThuCung'];
    return widget.appointment?.thuCung;
  }

  Future<String?> getDichVu() async {
    widget.appointment?.tenDichVu = await petServiceViewModel
        .getNameService(widget.appointment?.loaiDichVu);
    return widget.appointment?.tenDichVu;
  }

  Future<void> changeStatus(String? stateChoose) async {
    setState(() {
      widget.appointment?.trangThai = stateChoose;
    });
  }

  Future<void> changeNoti(bool? thongBao) async {
  if (!mounted) return;  // Check if the widget is still mounted
  setState(() {
    widget.appointment?.thongBao = thongBao;
  });
}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(blurRadius: 0.1, offset: Offset(0.5, 0.5))
                ]),
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                FutureBuilder<ImagePet?>(
                    future: getHinhAnh(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: const CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 25,
                            backgroundImage: AssetImage('images/cat.png'),
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25,
                          backgroundImage:
                              MemoryImage(widget.appointment!.thuCung!.data),
                        );
                      }
                    }),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String?>(
                          future: getDichVu(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Container(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return Text(
                                "${widget.appointment?.tenDichVu}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              );
                            }
                          }),
                      Text(
                        "${DateFormat('dd/MM/yyyy').format(widget.appointment!.ngayKham!)}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Column(children: [
                  widget.appointment?.trangThai == "Đã xác nhận"
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppointmentDetail(
                                          appointment: widget.appointment,
                                          onChangeStatus: (stateChoose) async {
                                            await changeStatus(stateChoose);
                                          },
                                          onChangeNoti: (thongBao) async {
                                            await changeNoti(thongBao);
                                          },
                                        )));
                          },
                          child: const Text(
                            "Đã xác nhận",
                            style: TextStyle(
                                color: Color(0xff00FF29),
                                fontWeight: FontWeight.bold),
                          ))
                      : widget.appointment?.trangThai == "Xem kết quả khám bệnh"
                          ? TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Xem kết quả khám bệnh",
                                style: TextStyle(
                                    color: Color(0xffF48B29),
                                    fontWeight: FontWeight.bold),
                              ))
                          : IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AppointmentDetail(
                                              appointment: widget.appointment,
                                              onChangeStatus:
                                                  (stateChoose) async {
                                                await changeStatus(stateChoose);
                                              },
                                              onChangeNoti: (thongBao) async {
                                                await changeNoti(thongBao);
                                              },
                                            )));
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_right,
                                size: 33,
                              )),
                  Text(
                    "23:43 - 1/6/2024",
                    style: TextStyle(color: Color(0xffABABAB)),
                  ),
                ])),
              ],
            ),
          ),
          Positioned(
              top: 5,
              right: 10,
              child: widget.appointment?.thongBao == false
                  ? CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 8,
                    )
                  : SizedBox.shrink()),
        ],
      ),
    );
  }
}
