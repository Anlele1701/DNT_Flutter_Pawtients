import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:frontend/view_model/petservice_view_model.dart';
import 'package:intl/intl.dart';

class ItemListView extends StatefulWidget {
  ItemListView({super.key, this.appointment});
  Appointment? appointment;
  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  String? date = '';
  String? dichVu = "";
  String? ngayKham;
  PetserviceViewModel petserviceViewModel = PetserviceViewModel();
  PetViewModel petViewModel = PetViewModel();
  Pet? pet;
  Future<void> getService() async {
    String? tenDichVu =
        await petserviceViewModel.getService(widget.appointment?.loaiDichVu);
    Pet? petFind = await petViewModel.getPet(widget.appointment?.idThuCung);
    setState(() {
      dichVu = tenDichVu;
      pet = petFind;
      date = DateFormat('dd/MM/yyyy').format(widget.appointment!.ngayKham!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 56, 56, 56).withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 8,
              // spreadRadius: 1,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                color: Color(0xffFFC368)),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: pet!=null?Image.memory(
                  pet!.hinhAnh!.data,
                  fit: BoxFit.cover,
                ):Container()),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dichVu!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${date}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${pet?.tenThuCung} - Bác sĩ Ngọc',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 30,
              opticalSize: 30,
              color: Color(0xff555555),
            ),
          )
        ],
      ),
    );
  }
}
