import 'package:frontend_ad/models/image_model.dart';
import 'package:frontend_ad/models/order.dart';

class Bill{
  String? chanDoan;
  List<Order?>? keDonThuoc;
  String? phiDichVu;
  List<ImagePet?>? hinhAnh;
  int? tongTien;
  String? idLichKham;

  Bill({this.chanDoan, this.keDonThuoc, this. phiDichVu, this.hinhAnh, this.tongTien, this.idLichKham});
  Bill.fromJson(Map<String, dynamic> json){
    chanDoan = json["chanDoan"];
    keDonThuoc = json["keDonThuoc"].map((e) => Order.fromJson(e)).toList();
    phiDichVu = json["phiDichVu"];
    hinhAnh = json["hinhAnh"].map((e) => ImagePet.fromjson(e)).toList();
    tongTien = json["tongTien"];
    idLichKham = json["idLichKham"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json=Map<String, dynamic>();
    json["chanDoan"] = chanDoan;
    json["keDonThuoc"] = keDonThuoc?.map((e) => e?.toJson()).toList();
    json["phiDichVu"] = phiDichVu;
    json['tongTien']=tongTien;
    json['idLichKham']=idLichKham;
    return json;
  }
}