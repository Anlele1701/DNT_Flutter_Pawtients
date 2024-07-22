import 'package:frontend/model/image_model.dart';

class Drug {
  String? tenThuoc;
  String? hangThuoc;
  String? moTa;
  String? thanhPhan;
  int? giaTien;
  String? phongBenh;
  ImagePet? hinhAnh;
  int? soLuong;

  Drug(
      {this.tenThuoc,
      this.hangThuoc,
      this.moTa,
      this.thanhPhan,
      this.giaTien,
      this.phongBenh,
      this.hinhAnh,
      this.soLuong});

  Drug.fromJson(Map<String, dynamic> json) {
    tenThuoc = json['tenThuoc'];
    hangThuoc = json['hangThuoc'];
    moTa = json['moTa'];
    thanhPhan = json['thanhPhan'];
    giaTien = json['giaTien'];
    phongBenh = json['phongBenh'];
    hinhAnh = ImagePet.fromjson(json['hinhAnh']);
    soLuong = json['soLuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenThuoc'] = this.tenThuoc;
    data['hangThuoc'] = this.hangThuoc;
    data['moTa'] = this.moTa;
    data['thanhPhan'] = this.thanhPhan;
    data['giaTien'] = this.giaTien;
    data['phongBenh'] = this.phongBenh;
    data['soLuong'] = this.soLuong;
    return data;
  }
}
