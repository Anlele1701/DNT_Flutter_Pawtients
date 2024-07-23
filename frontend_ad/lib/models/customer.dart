import 'package:frontend_ad/models/image_model.dart';

class Customer {
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
      {this.hoTen,
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
    hoTen = json["hoTen"];
    sdt = json["sdt"];
    password = json["password"];
    email = json["email"];
    gender = json["gender"];
    diem = json["diem"];
    diaChi = json["diaChi"];
    hangThanhVien = json["hangThanhVien"];
    dsThuCung = json['dsThuCung'] != null
        ? json["dsThuCung"]?.map((e) => e).toList()
        : [];
    dsLichKham = json['dsLichKham'] != null
        ? json["dsLichKham"]?.map((e) => e).toList()
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
