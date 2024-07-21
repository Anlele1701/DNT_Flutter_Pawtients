import 'package:frontend_ad/models/image_model.dart';

class Employee {
  String? hoten;
  String? sdt;
  bool? gioiTinh;
  ImagePet? hinhAnh;
  String? tenTK;
  String? matKhau;
  String? chucVu;
  Employee(
      {this.hoten,
      this.sdt,
      this.gioiTinh,
      this.hinhAnh,
      this.tenTK,
      this.matKhau,
      this.chucVu});
  Employee.fromJson(Map<String, dynamic> json) {
    hoten = json['hoTen'];
    sdt = json['sdt'];
    gioiTinh = json['gioiTinh'];
    hinhAnh = ImagePet.fromjson(json['hinhAnh']);
    tenTK = json['tenTK'];
    matKhau = json['matKhau'];
    chucVu = json['chucVu'];
  }
}
