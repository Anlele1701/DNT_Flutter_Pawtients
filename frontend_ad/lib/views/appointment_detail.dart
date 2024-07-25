import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_ad/models/appointment.dart';
import 'package:frontend_ad/views/bill_detail.dart';
import 'package:frontend_ad/views/create_bill.dart';
import 'package:frontend_ad/views/public_views/appbar.dart';
import 'package:frontend_ad/views/public_views/appbar_drawer.dart';
import 'package:frontend_ad/views/widget/ToastNoti.dart';
import 'package:frontend_ad/views_models/appointment_view_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentDetail(
      {super.key, this.appointment, this.onChangeStatus, this.onChangeNoti});
  Appointment? appointment;
  Function(String?)? onChangeStatus;
  Function(bool?)? onChangeNoti;
  @override
  State<AppointmentDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentDetail> {
  String? stateChoose;
  bool? thongBao;
  AppointmentViewModel appointmentViewModel = AppointmentViewModel();
  @override
  void initState() {
    super.initState();
    stateChoose = "${widget.appointment?.trangThai}";
    thongBao = widget.appointment?.thongBao;
    if (widget.appointment?.thongBao == false) updateNoti();
  }

  Future<void> updateNoti() async {
    await appointmentViewModel.updateNoti(widget.appointment?.id);
    setState(() {
      thongBao = true;
    });
  }

  final List<String> listState = [
    "Chưa xác nhận",
    "Đã xác nhận",
    "Đã khám",
    "Hoàn thành"
  ];
  String? tinhTrangBenh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDrawer(title: "Chi tiết lịch khám"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff000000)),
                          height: 150,
                          width: 150,
                          child: widget.appointment?.thuCung?.data != null
                              ? Image.memory(widget.appointment!.thuCung!.data)
                              : Container()),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Tên thú cưng: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "${widget.appointment?.tenThuCung}",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          const Text(
                            "Đặt ngày:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${DateFormat('dd/MM/yyyy').format(widget.appointment!.ngayKham!)}",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text("Dịch vụ khám: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      Text("${widget.appointment?.tenDichVu}",
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Trạng thái: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border: Border.all(color: (Colors.grey)),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          value: stateChoose,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              stateChoose = newValue;
                            });
                          },
                          items: listState
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: tinhTrangBenh != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tình trạng bệnh: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  "Bé có dấu hiệu nôn mửa, biếng ăn, thường xuyên nổi cáu với mn xung quanh.",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.appointment?.idHoaDon == null
                      ? Column(
                          children: [
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                  color: Color(0xffF48B29),
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                  onPressed: () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    String? idNV = pref.getString('id');
                                    final result =
                                        await appointmentViewModel.updateStatus(
                                            stateChoose,
                                            widget.appointment?.id,
                                            idNV);
                                    if (result is Appointment) {
                                      successToast(
                                          "Cập nhật lịch khám thành công");
                                      widget.onChangeNoti!(thongBao);
                                      widget.onChangeStatus!(stateChoose);
                                      Navigator.pop(context);
                                    } else {
                                      errorToast('Cập nhật lịch khám thất bại',
                                          'Lỗi server');
                                    }
                                  },
                                  child: const Text(
                                    "Lưu trạng thái",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                  color: const Color(0xff00A1E6),
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                  onPressed: () {
                                    if (widget.appointment?.trangThai ==
                                        "Chưa xác nhận") {
                                      errorToast("Không thể tạo hóa đơn",
                                          "Lịch khám chưa được xác nhận");
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CreateBill(
                                                  appointment:
                                                      widget.appointment)));
                                    }
                                  },
                                  child: const Text(
                                    "Tạo hóa đơn",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        )
                      : Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: const Color(0xff00A1E6),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BillDetail(
                                            idHD:
                                                widget.appointment?.idHoaDon)));
                              },
                              child: const Text(
                                "Xem hóa đơn",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
