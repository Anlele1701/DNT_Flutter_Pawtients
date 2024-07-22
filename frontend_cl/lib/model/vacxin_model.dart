import 'package:frontend/model/image_model.dart';

class Vacxin{
  String? id;
  String? tenVacxin;
  String? phongBenh;
  String? hangVacxin;
  String? moTa;
  int? soLuong;
  int? giaTien;
  String? quocGia;
  ImagePet? hinhAnh;
  Vacxin({this.id, this.tenVacxin, this.phongBenh, this.moTa, this.soLuong, this.giaTien, this.quocGia, this.hinhAnh, this.hangVacxin});
  Vacxin.fromJson(Map<String, dynamic> json){
    id=json['_id'];
    tenVacxin= json['tenVacxin'];
    hangVacxin=json['hangVacxin'];
    phongBenh=json['phongBenh'];
    moTa=json['moTa'];
    soLuong=json['soLuong'];
    giaTien=json['giaTien'];
    quocGia=json['quocGia'];
    hinhAnh=ImagePet.fromjson(json['hinhAnh']);
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data=Map<String, dynamic>();
      data['id']=id;
      data['tenVacxin']= tenVacxin;
      data['quocGia']=quocGia;
      data['moTa']=moTa;
      data['soLuong']=soLuong;
      data['giaTien']=giaTien;
      data['phongBenh']=phongBenh;
      data['hangVacxin']=hangVacxin;
      return data;
  }
}