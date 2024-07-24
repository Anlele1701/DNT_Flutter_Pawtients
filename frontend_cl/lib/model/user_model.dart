import 'package:frontend/model/image_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

@JsonSerializable()
class User{
  String? id;
  String? hoTen;
  String? sdt;
  String? password;
  String? email;
  int? diem;
  String? hangThanhVien;
  List<String>? dsThuCung;
  List<String?>? dsLichKham;
  ImagePet? image;

  User({this.id, this.hoTen, this.sdt='', this.password, this.email, this.diem=0, this.hangThanhVien='', this.dsThuCung, this.image=null, this.dsLichKham=null});
  User.fromJson(Map<String, dynamic> json){
    id=json["_id"];
    hoTen=json["hoTen"];
    if(json['sdt']==null) sdt='';
    else sdt=json["sdt"];
    password=json["password"];
    email=json["email"];
    if(json['diem']==null) diem=0;
    else diem=json["diem"];
    if(json['hangThanhVien']==null) hangThanhVien='';
    else hangThanhVien=json["hangThanhVien"];
    if(json['dsThuCung']==null) dsThuCung=[];
    else dsThuCung=json["dsThuCung"]?.cast<String>();
    if(json['hinhAnh']==null) image=null;
    else image=ImagePet.fromjson(json["hinhAnh"]);
    if(json['dsLichkham']==null) dsLichKham=null;
    else dsLichKham=json["dsLichkham"]?.cast<String>();
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data= Map<String, dynamic>();
    data['_id']=id;
    data['hoTen']=hoTen;
    data['sdt']=sdt;
    data['password']=password;
    data['email']=email;
    data['diem']=diem;
    data['hangThanhVien']=hangThanhVien;
    data['dsThuCung']=dsThuCung;
    data['dsLichkham']=dsLichKham;
    data['hinhAnh']=image?.toJson();
    return data;
  }
}