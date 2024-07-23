class Order{
  String? idThuoc;
  int? soLuong;
  int? thanhTien;
  Order({this.idThuoc, this.soLuong, this.thanhTien});
  Order.fromJson(Map<String, dynamic> json){
    idThuoc = json['idThuoc'];
    soLuong = json['soLuong'];
    thanhTien = json['thanhTien'];
  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> json= Map<String, dynamic>();
    json['idThuoc'] = idThuoc;
    json['soLuong'] = soLuong;
    json['thanhTien'] = thanhTien;
    return json;
  }
}