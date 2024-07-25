import 'package:frontend_ad/models/image_model.dart';

class Appointment{
  String? id;
  DateTime? ngayKham;
  String? loaiDichVu;
  String? tinhTrangBenh;
  String? trangThai;
  String? idNV;
  String? idHoaDon;
  String? idThuCung;
  bool? thongBao;
  ImagePet? thuCung;
  String? tenDichVu;
  String? tenThuCung;
  Appointment({this.id, this.ngayKham, this.idHoaDon=null, this.loaiDichVu, this.tinhTrangBenh='', this.trangThai=null, this.idNV=null, this.idThuCung, this.thongBao=false});
  Appointment.fromJson(Map<String, dynamic> json){
    print(json['_id']);
    id=json["_id"];
    ngayKham=DateTime.parse(json['ngayKham']);
    loaiDichVu=json['loaiDichVu'];
    tinhTrangBenh=json['tinhTrangBenh'];
    trangThai=json['trangThai'];
    idNV=json['idNV'];
    idThuCung=json['idThuCung'];
    if(json['thongBao']==true)thongBao=true;
    else thongBao=false;
    idHoaDon=json['idHoaDon'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data=Map<String, dynamic>();
    data["id"]=id;
    data['ngayKham']=ngayKham?.toIso8601String();
    data['loaiDichVu']=loaiDichVu;
    data['tinhTrangBenh']=tinhTrangBenh;
    if(trangThai!=null) data['trangThai']=trangThai;
    data['idNV']=idNV;
    data['idThuCung']=idThuCung;
    data['thongBao']=thongBao;
    data['idHoaDon']=idHoaDon;
    return data;
  }
}