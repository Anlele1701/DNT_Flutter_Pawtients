import { Image } from "src/schemas/Image";

export class UpdateVacxinDto{
    id: String;
    tenVacxin: String;
    phongBenh: String;
    hangVacxin: String;
    moTa: String;
    soLuong: number;
    giaTien: String;
    quocGia: String;
    hinhAnh: Image;
}