import 'package:frontend_ad/models/image_model.dart';

class Drug{
  String? id;
  String? tenThuoc;
  String? hangThuoc;
  String? moTa;
  int? soLuong;
  int? giaTien;
  String? phongBenh;
  ImagePet? hinhAnh;
  Drug({this.id, this.tenThuoc, this.hangThuoc, this.moTa, this.soLuong, this.giaTien, this.phongBenh, this.hinhAnh,});
  Drug.fromJson(Map<String, dynamic> json){
    id=json['_id'];
    tenThuoc= json['tenThuoc'];
    hangThuoc=json['hangThuoc'];
    moTa=json['moTa'];
    soLuong=json['soLuong'];
    giaTien=json['giaTien'];
    phongBenh=json['phongBenh'];
    hinhAnh=ImagePet.fromjson(json['hinhAnh']);
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data=Map<String, dynamic>();
      data['id']=id;
      data['tenThuoc']= tenThuoc;
      data['hangThuoc']=hangThuoc;
      data['moTa']=moTa;
      data['soLuong']=soLuong;
      data['giaTien']=giaTien;
      data['phongBenh']=phongBenh;
      return data;
  }
}