import 'package:frontend_ad/models/image_model.dart';

class Vacxin{
  String? id;
  String? tenVacxin;
  String? phongBenh;
  String? hangVacxin;
  String? moTa;
  String? thanhPhan;
  int? giaTien;
  String? quocGia;
  ImagePet? hinhAnh;
  Vacxin({this.id, this.tenVacxin, this.phongBenh, this.moTa, this.thanhPhan, this.giaTien, this.quocGia, this.hinhAnh, this.hangVacxin});
  Vacxin.fromJson(Map<String, dynamic> json){
    id=json['_id'];
    tenVacxin= json['tenVacxin'];
    hangVacxin=json['hangVacxin'];
    phongBenh=json['phongBenh'];
    moTa=json['moTa'];
    thanhPhan=json['thanhPhan'];
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
      data['thanhPhan']=thanhPhan;
      data['giaTien']=giaTien;
      data['phongBenh']=phongBenh;
      data['hangVacxin']=hangVacxin;
      return data;
  }
}