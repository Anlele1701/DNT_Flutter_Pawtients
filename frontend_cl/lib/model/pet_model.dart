import 'package:frontend/model/appointment_model.dart';
import 'package:frontend/model/image_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

@JsonSerializable()
class Pet{
  String? id;
  String? tenThuCung;
  DateTime? ngaySinh;
  String? loaiThuCung;
  String? giongLoai;
  bool? gioiTinh;
  String? canNang;
  ImagePet? hinhAnh;
  List<String>? dsLichKham;
  Pet({this.tenThuCung, this.ngaySinh, this.loaiThuCung, this.giongLoai, this.gioiTinh, this.canNang, this.hinhAnh});
  
  Pet.fromJson(Map<String, dynamic> json){
    id=json['_id'];
    tenThuCung=json['tenThuCung'];
    ngaySinh=DateTime.parse(json['ngaySinh']);
    loaiThuCung=json['loaiThuCung'];
    giongLoai=json['giongLoai'];
    gioiTinh=json['gioiTinh'];
    canNang=json['canNang'];
    hinhAnh=ImagePet.fromjson(json['hinhAnh']);
    if(json['dsLichKham']!=null){
      if (json['dsLichKham'] != null) {
      dsLichKham = List<String>.from(json['dsLichKham']);
    }
    }
    else dsLichKham=[];
  }

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data=Map<String,dynamic>();
    data['_id']=id;
    data['tenThuCung']=tenThuCung;
    data['ngaySinh']=ngaySinh;
    data['loaiThuCung']=loaiThuCung;
    data['giongLoai']=giongLoai;
    data['gioiTinh']=gioiTinh;
    data['canNang']=canNang;
    if (dsLichKham != null) {
      data['dsLichKham'] = dsLichKham;
    }
    return data;
  }
}