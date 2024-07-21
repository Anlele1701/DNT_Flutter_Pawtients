import { Image } from "src/schemas/Image";

export class CreateNewVacxinDto{
    tenVacxin: String;
    phongBenh: String;
    hangVacxin: String;
    moTa: String;
    thanhPhan: String;
    giaTien: String;
    quocGia: String;
    hinhAnh: Image;
}