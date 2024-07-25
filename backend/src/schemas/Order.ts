export class Order{
    idThuoc: String;
    soLuong: number;
    thanhTien: number;
    constructor(idThuoc: String, soLuong: number, thanhTien: number){
        this.idThuoc = idThuoc;
        this.soLuong = soLuong;
        this.thanhTien = thanhTien;
    }
}