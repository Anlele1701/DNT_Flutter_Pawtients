import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PetService {
  String? tenDichVu;
  String? moTa;
  int? giaTien;
  PetService({this.tenDichVu, this.moTa, this.giaTien});

  PetService.fromJson(Map<String, dynamic> json) {
    tenDichVu = json['tenDichVu'];
    moTa = json['moTa'];
    giaTien = json['giaTien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tenDichVu'] = this.tenDichVu;
    data['moTa'] = this.moTa;
    data['giaTien'] = this.giaTien;
    return data;
  }
}
