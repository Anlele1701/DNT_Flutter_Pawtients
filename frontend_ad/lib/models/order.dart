class Order{
  String? idThuoc;
  String? tenThuoc;
  int? soLuong;
  int? giaTien;
  int? thanhTien;
  Order({this.idThuoc, this.tenThuoc, this.soLuong, this.thanhTien, this.giaTien});
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