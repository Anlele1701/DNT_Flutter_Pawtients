import { Image } from "src/schemas/Image";

export class UpdateVacxinDto{
    id: String;
    tenVacxin: String;
    phongBenh: String;
    hangVacxin: String;
    moTa: String;
    thanhPhan: String;
    giaTien: String;
    quocGia: String;
    hinhAnh: Image;
}