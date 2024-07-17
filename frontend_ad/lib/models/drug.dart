import 'package:frontend_ad/models/image_model.dart';

class Drug{
  String? tenThuoc;
  String? hangThuoc;
  String? moTa;
  String? thanhPhan;
  int? giaTien;
  String? phongBenh;
  ImagePet? hinhAnh;
  Drug({this.tenThuoc, this.hangThuoc, this.moTa, this.thanhPhan, this.giaTien, this.phongBenh, this.hinhAnh,});
  Drug.fromJson(Map<String, dynamic> json){
    tenThuoc= json['tenThuoc'];
    hangThuoc=json['hangThuoc'];
    moTa=json['moTa'];
    thanhPhan=json['thanhPhan'];
    giaTien=json['giaTien'];
    phongBenh=json['phongBenh'];
    hinhAnh=ImagePet.fromjson(json['hinhAnh']);
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data=Map<String, dynamic>();
      data['tenThuoc']= tenThuoc;
      data['hangThuoc']=hangThuoc;
      data['moTa']=moTa;
      data['thanhPhan']=thanhPhan;
      data['giaTien']=giaTien;
      data['phongBenh']=phongBenh;
      return data;
  }
}