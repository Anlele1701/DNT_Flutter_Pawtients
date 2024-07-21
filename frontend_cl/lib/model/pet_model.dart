import 'package:frontend/model/image_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

@JsonSerializable()
class Pet{
  String? tenThuCung;
  DateTime? ngaySinh;
  String? loaiThuCung;
  String? giongLoai;
  bool? gioiTinh;
  String? canNang;
  ImagePet? hinhAnh;
  Pet({this.tenThuCung, this.ngaySinh, this.loaiThuCung, this.giongLoai, this.gioiTinh, this.canNang, this.hinhAnh});
  
  Pet.fromJson(Map<String, dynamic> json){
    tenThuCung=json['tenThuCung'];
    ngaySinh=DateTime.parse(json['ngaySinh']);
    loaiThuCung=json['loaiThuCung'];
    giongLoai=json['giongLoai'];
    gioiTinh=json['gioiTinh'];
    canNang=json['canNang'];
    hinhAnh=ImagePet.fromjson(json['hinhAnh']);
  }

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data=Map<String,dynamic>();
    data['tenThuCung']=tenThuCung;
    data['ngaySinh']=ngaySinh;
    data['loaiThuCung']=loaiThuCung;
    data['giongLoai']=giongLoai;
    data['gioiTinh']=gioiTinh;
    data['canNang']=canNang;
    return data;
  }
}