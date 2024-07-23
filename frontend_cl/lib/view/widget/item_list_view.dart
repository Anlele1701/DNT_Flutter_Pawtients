import 'package:flutter/material.dart';
import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/pet_model.dart';
import 'package:frontend/view/widget/appointment_detail.dart';
import 'package:frontend/view_model/pet_view_model.dart';
import 'package:frontend/view_model/petservice_view_model.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ItemListView extends StatefulWidget {
  ItemListView({super.key, this.appointment});
  Appointment? appointment;
  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  String? date = '';
  String? dichVu = "";
  PetserviceViewModel petserviceViewModel = PetserviceViewModel();
  PetViewModel petViewModel = PetViewModel();
  Pet? pet;
  bool isLoading = true; // Add a loading state

  Future<void> getService() async {
    String? tenDichVu =
        await petserviceViewModel.getService(widget.appointment?.loaiDichVu);
    Pet? petFind = await petViewModel.getPet(widget.appointment?.idThuCung);
    setState(() {
      dichVu = tenDichVu;
      pet = petFind;
      date = DateFormat('dd/MM/yyyy').format(widget.appointment!.ngayKham!);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getService();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: Color(0xffFFC368),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.grey,
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
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AppointmentDetail(appointment: widget.appointment))),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              padding: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 56, 56, 56)
                          .withOpacity(0.2),
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        color: Color(0xffFFC368)),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: pet != null
                            ? pet?.loaiThuCung == "Mèo"
                                ? Image.asset('assets/images/catprofile.png',
                                    width: 20, height: 27)
                                : Image.asset('assets/images/dogprofile.png',
                                    width: 20, height: 27)
                            : const Icon(
                                Icons.pets,
                                size: 30,
                                color: Colors.white,
                              )),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dichVu!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '$date',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${pet?.tenThuCung} - Bác sĩ Ngọc',
                        style: const TextStyle(
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
            ),
          );
  }
}
