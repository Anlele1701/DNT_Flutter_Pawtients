class PetServiceModel{
  String? id;
  String? tenDichVu;
  String? moTa;
  int? giaTien;
  PetServiceModel.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    tenDichVu = json['tenDichVu'];
    moTa = json['moTa'];
    giaTien = json['giaTien'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data=Map<String, dynamic>();
    data['_id'] =id;
    data['tenDichVu'] = tenDichVu;
    data['moTa'] = moTa;
    data['giaTien'] = giaTien;
    return data;
  }
}