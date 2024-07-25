import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/order.dart';

class Bill{
  String? id;
  String? chanDoan;
  List<Order?>? keDonThuoc;
  String? phiDichVu;
  List<ImagePet?>? hinhAnh;
  int? tongTien;
  String? idLichKham;
  String? tenDichVu;
  String? tenThuCung;
  DateTime? ngayKham;

  Bill({this.chanDoan, this.keDonThuoc, this. phiDichVu, this.hinhAnh, this.tongTien, this.idLichKham});
  Bill.fromJson(Map<String, dynamic> json){
    id=json['_id'];
    chanDoan = json["chanDoan"];
    keDonThuoc = (json["keDonThuoc"]as List<dynamic>).map((e) => Order.fromJson(e)).toList();
    phiDichVu = json["phiDichVu"];
    hinhAnh = (json["hinhAnh"] as List<dynamic>).map((e) => ImagePet.fromjson(e)).toList();
    tongTien = json["tongTien"];
    idLichKham = json["idLichKham"];
    tenDichVu=json['tenDichVu'];
    tenThuCung= json['tenThuCung'];
    ngayKham= DateTime.parse(json['ngayKham']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json=Map<String, dynamic>();
    json["chanDoan"] = chanDoan;
    json["keDonThuoc"] = keDonThuoc?.map((e) => e?.toJson()).toList();
    json["phiDichVu"] = phiDichVu;
    json['tongTien']=tongTien;
    json['idLichKham']=idLichKham;
    json['tenThuCung']=tenThuCung;
    json['tenDichVu']=tenDichVu;
    json['ngayKham']=ngayKham?.toIso8601String();
    return json;
  }
}