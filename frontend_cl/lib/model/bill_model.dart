import 'package:frontend/model/drug_model.dart';
import 'package:frontend/model/image_model.dart';
import 'package:frontend/model/vacxin_model.dart';
class Bill {
  String? chanDoan;
  String? phiDichVu;
  List<KeDonThuocItem>? keDonThuoc;
  List<ImagePet>? hinhAnh;
  int? tongTien;
  String? idLichKham;

  Bill({this.chanDoan, this.phiDichVu, this.keDonThuoc, this.hinhAnh, this.tongTien, this.idLichKham});

  Bill.fromJson(Map<String, dynamic> json) {
    chanDoan = json['chanDoan'];
    phiDichVu = json['phiDichVu'];
    if (json['keDonThuoc'] != null) {
      keDonThuoc = [];
      json['keDonThuoc'].forEach((v) {
        keDonThuoc?.add(KeDonThuocItem.fromJson(v));
      });
    }
    if (json['hinhAnh'] != null) {
      hinhAnh = [];
      json['hinhAnh'].forEach((v) {
        hinhAnh?.add(ImagePet.fromjson(v));
      });
    }
    tongTien = json['tongTien'];
    idLichKham = json['idLichKham'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chanDoan'] = chanDoan;
    data['phiDichVu'] = phiDichVu;
    if (keDonThuoc != null) {
      data['keDonThuoc'] = keDonThuoc?.map((v) => v.toJson()).toList();
    }
    if (hinhAnh != null) {
      data['hinhAnh'] = hinhAnh?.map((v) => v.toJson()).toList();
    }
    data['tongTien'] = tongTien;
    data['idLichKham'] = idLichKham;
    return data;
  }
}


class KeDonThuocItem {
  dynamic idThuoc; // Vacxin or Drug
  int? soLuong;
  int? thanhTien;

  KeDonThuocItem({this.idThuoc, this.soLuong, this.thanhTien});

  KeDonThuocItem.fromJson(Map<String, dynamic> json) {
    if (json['idThuoc']['type'] == 'Drug') {
      idThuoc = Drug.fromJson(json['idThuoc']);
    } else {
      idThuoc = Vacxin.fromJson(json['idThuoc']);
    }
    soLuong = json['soLuong'];
    thanhTien = json['thanhTien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idThuoc'] = idThuoc is Drug ? (idThuoc as Drug).toJson() : (idThuoc as Vacxin).toJson();
    data['soLuong'] = soLuong;
    data['thanhTien'] = thanhTien;
    return data;
  }
}