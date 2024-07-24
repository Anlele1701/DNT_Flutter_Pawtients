class Employee{
  String? id;
  String? hoTen;
  String? sdt;
  bool? gioiTinh;
  String? tenTK;
  String? matKhau;
  String? chucVu;
  Employee.fromJson(Map<String, dynamic> json){
    id=json["_id"];
    hoTen=json["hoTen"];
    sdt=json["sdt"];
    gioiTinh=json["gioiTinh"];
    tenTK=json["tenTK"];
    matKhau=json["matKhau"];
    chucVu=json["chucVu"];
  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data=Map<String, dynamic>();
    data["_id"]=id;
    data["hoTen"]=hoTen;
    data["sdt"]=sdt;
    data["gioiTinh"]=gioiTinh;
    data["tenTK"]=tenTK;
    data["matKhau"]=matKhau;
    data["chucVu"]=chucVu;
    return data;
  }
}