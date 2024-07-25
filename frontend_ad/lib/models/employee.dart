import 'package:frontend_ad/models/image_model.dart';

class Employee {
  String? id;
  String? hoten;
  String? sdt;
  bool? gioiTinh;
  ImagePet? hinhAnh;
  String? tenTK;
  String? matKhau;
  String? chucVu;
  Employee(
      {this.id,
      this.hoten,
      this.sdt,
      this.gioiTinh,
      this.hinhAnh,
      this.tenTK,
      this.matKhau,
      this.chucVu});
  Employee.fromJson(Map<String, dynamic> data) {
    id = data['_id'];
    hoten = data["hoTen"];
    sdt = data["sdt"];
    gioiTinh = data["gioiTinh"];
    tenTK = data["tenTK"];
    matKhau = data["matKhau"];
    chucVu = data["chucVu"];
    hinhAnh =
        data["hinhAnh"] != null ? ImagePet.fromjson(data["hinhAnh"]) : null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["hoTen"] = hoten;
    data["sdt"] = sdt;
    data["gioiTinh"] = gioiTinh;
    data['hinhAnh'] != null ? hinhAnh!.toJson() : null;
    data["tenTK"] = tenTK;
    data["matKhau"] = matKhau;
    data["chucVu"] = chucVu;
    return data;
  }
}
