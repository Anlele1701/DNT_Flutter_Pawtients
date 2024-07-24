import 'package:frontend_ad/models/image_model.dart';

class Customer {
  String? id;
  String? hoTen;
  String? sdt;
  String? password;
  String? email;
  bool? gender;
  int? diem;
  String? diaChi;
  String? hangThanhVien;
  List<String?>? dsThuCung;
  List<String?>? dsLichKham;
  ImagePet? hinhAnh;

  Customer(
      {this.id,
      this.hoTen,
      this.sdt,
      this.password,
      this.email,
      this.gender,
      this.diem,
      this.diaChi,
      this.hangThanhVien,
      this.dsThuCung,
      this.dsLichKham,
      this.hinhAnh});
  Customer.fromJson(Map<String, dynamic> json) {
    id=json['_id'];
    hoTen = json["hoTen"];
    sdt = json["sdt"];
    password = json["password"];
    email = json["email"];
    gender = json["gender"];
    diem = json["diem"];
    diaChi = json["diaChi"];
    hangThanhVien = json["hangThanhVien"];
    dsThuCung = json['dsThuCung'] != []
        ? (json["dsThuCung"] as List<dynamic>).map((e) => e as String?).toList()
        : [];
    dsLichKham = json['dsLichKham'] != []
        ? (json["dsLichKham"] as List<dynamic>)
            .map((e) => e as String?)
            .toList()
        : [];
    hinhAnh =
        json['hinhAnh'] != null ? ImagePet.fromjson(json["hinhAnh"]) : null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json["hoTen"] = hoTen;
    json["sdt"] = sdt;
    json["password"] = password;
    json["email"] = email;
    json["gender"] = gender;
    json["diem"] = diem;
    json["diaChi"] = diaChi;
    json["hangThanhVien"] = hangThanhVien;
    json["dsThuCung"] =
        dsThuCung != [] ? dsThuCung?.map((e) => e).toList() : [];
    json["dsLichKham"] =
        dsLichKham != [] ? dsLichKham?.map((e) => e).toList() : [];
    json["hinhAnh"] = hinhAnh != null ? hinhAnh?.toJson() : null;
    return json;
  }
}
